targetScope = 'resourceGroup'

@description('Azure region for all lab resources.')
param location string = resourceGroup().location

@description('Prefix used for generated resource names.')
@minLength(3)
@maxLength(12)
param namePrefix string = 'amahblab'

@description('Virtual machine name used in the Heartbeat query.')
param vmName string = 'vm-ama-heartbeat-loss'

@description('Administrator username for the Linux VM.')
param adminUsername string = 'azureuser'

@description('Administrator password for the Linux VM. Replace the placeholder before deployment.')
@secure()
param adminPassword string

@description('Virtual machine size.')
param vmSize string = 'Standard_B2s'

@description('Log Analytics workspace name.')
param workspaceName string = 'law-ama-heartbeat-loss'

@description('Data collection rule name.')
param dcrName string = 'dcr-ama-heartbeat-loss'

@description('Data collection rule association name.')
param associationName string = 'ama-heartbeat-loss'

@description('Virtual network address space.')
param virtualNetworkAddressPrefix string = '10.42.0.0/16'

@description('Subnet address space for the VM.')
param subnetAddressPrefix string = '10.42.0.0/24'

@description('Log Analytics retention in days.')
@minValue(30)
@maxValue(730)
param workspaceRetentionInDays int = 30

var networkSecurityGroupName = '${namePrefix}-nsg'
var virtualNetworkName = '${namePrefix}-vnet'
var nicName = '${vmName}-nic'

resource workspace 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: workspaceName
  location: location
  properties: {
    retentionInDays: workspaceRetentionInDays
    features: {
      enableLogAccessUsingOnlyResourcePermissions: true
    }
  }
  sku: {
    name: 'PerGB2018'
  }
}

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2024-05-01' = {
  name: networkSecurityGroupName
  location: location
  properties: {
    securityRules: []
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        virtualNetworkAddressPrefix
      ]
    }
    subnets: [
      {
        name: 'default'
        properties: {
          addressPrefix: subnetAddressPrefix
          networkSecurityGroup: {
            id: networkSecurityGroup.id
          }
        }
      }
    ]
  }
}

resource nic 'Microsoft.Network/networkInterfaces@2024-05-01' = {
  name: nicName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: virtualNetwork.properties.subnets[0].id
          }
        }
      }
    ]
  }
}

resource vm 'Microsoft.Compute/virtualMachines@2024-03-01' = {
  name: vmName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
      linuxConfiguration: {
        disablePasswordAuthentication: false
      }
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: '0001-com-ubuntu-server-jammy'
        sku: '22_04-lts-gen2'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'StandardSSD_LRS'
        }
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
          properties: {
            primary: true
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: false
      }
    }
  }
}

resource amaExtension 'Microsoft.Compute/virtualMachines/extensions@2024-03-01' = {
  parent: vm
  name: 'AzureMonitorLinuxAgent'
  location: location
  properties: {
    publisher: 'Microsoft.Azure.Monitor'
    type: 'AzureMonitorLinuxAgent'
    typeHandlerVersion: '1.0'
    autoUpgradeMinorVersion: true
    enableAutomaticUpgrade: true
    settings: {}
  }
}

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2023-03-11' = {
  name: dcrName
  location: location
  kind: 'Linux'
  properties: {
    description: 'Collect baseline Linux guest signals so AMA heartbeat is active until the association is removed.'
    dataSources: {
      performanceCounters: [
        {
          name: 'perfCounterDataSource'
          streams: [
            'Microsoft-Perf'
          ]
          samplingFrequencyInSeconds: 60
          counterSpecifiers: [
            '\\Processor Information(_Total)\\% Processor Time'
            '\\Memory\\Available MBytes'
          ]
        }
      ]
      syslog: [
        {
          name: 'syslogDataSource'
          streams: [
            'Microsoft-Syslog'
          ]
          facilityNames: [
            '*'
          ]
          logLevels: [
            'Warning'
            'Error'
            'Critical'
          ]
        }
      ]
    }
    destinations: {
      logAnalytics: [
        {
          name: 'logAnalyticsDestination'
          workspaceResourceId: workspace.id
        }
      ]
    }
    dataFlows: [
      {
        streams: [
          'Microsoft-Perf'
          'Microsoft-Syslog'
        ]
        destinations: [
          'logAnalyticsDestination'
        ]
      }
    ]
  }
}

resource dcrAssociation 'Microsoft.Insights/dataCollectionRuleAssociations@2022-06-01' = {
  name: associationName
  scope: vm
  properties: {
    description: 'Delete this association to reproduce AMA heartbeat loss, then recreate it to restore heartbeat flow.'
    dataCollectionRuleId: dataCollectionRule.id
  }
}

output vmName string = vm.name
output vmResourceId string = vm.id
output workspaceName string = workspace.name
output workspaceResourceId string = workspace.id
output dcrName string = dataCollectionRule.name
output dcrResourceId string = dataCollectionRule.id
output associationName string = dcrAssociation.name
