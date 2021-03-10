$Global:rg = @{
    Name     = "";
    Location = "centralus";
}

$Global:virtualNetwork = ""

$Global:subnetConfig = ""

$Global:vnet = @{
    Name              = "";
    ResourceGroupName = $Global:rg.Name;
    Location          = $Global:rg.Location;
    AddressPrefix     = "";
}

$Global:subnet = @{
    Name           = "";
    VirtualNetwork = $Global:virtualNetwork;
    AddressPrefix  = "";
}

$Global:vm = @{
    ResourceGroupName  = $Global:rg.Name
    Location           = $Global:rg.Location
    Name               = ""
    VirtualNetworkName = $Global:vnet.Name
}

$Global:status = ""

$Global:userInput = ""

function createRg {
    # need to collect rg name
    $Global:rg.Name = Read-Host -Prompt "Please enter Resource Group Name"
    if ($Global:rg.Name -ne "" ) {
        New-AzResourceGroup @rg -Confirm
        Read-Host "Press any key to continue"
        mainMenu
        Break
    }
    
}

function removeRg {
    Remove-AzResourceGroup $Global:rg.Name
    Read-Host "Press any key to continue"
    mainMenu
}

function createVm {
    New-AzVM @vm -AsJob
    Read-Host "Press any key to continue"
    mainMenu
}

function connectAzure {
    Read-Host "Press any key to continue"
    mainMenu
}

function connectVm {
    Read-Host "Press any key to continue"
    mainMenu
}

function createVmNetwork {
    
    $Global:virtualNetwork = New-AzVirtualNetwork @vnet
    Read-Host "Press any key to continue"
    mainMenu
}

function createVmSubnet {
    $Global:subnetConfig = Add-AzVirtualNetworkSubnetConfig @subnet
    Read-Host "Press any key to continue"
    mainMenu
}

function createStorage {
    Read-Host "Press any key to continue"
    mainMenu
}

function azContext {

}

function dabug {
    $Global:rg
    Read-Host "Press any key to continue"
    mainMenu
}

function Global:mainMenu {
    Write-Host -ForegroundColor "Yellow" "`n[A] Review Azure Context Information `n[C] Connect to Azure Account `n[G] Create New Resource Group `n[R] Remove Resource Group `n[V] Create New Virtual Machine `n[M] Connect to Virtual Machine `n[N] Create New Virtual Network `n[S] Create New Subnetwork `n[Q] Quit PowerShell Session"
    do {
        $status = Read-Host "Choose a Menu Item to Continue"
        switch ($status) {
            "A" { azContext }
            "C" { connectAzure }
            "G" { createRg }
            "R" { removeRg }
            "V" { createVm }
            "M" { connectVm }
            "N" { createVmNetwork }
            "S" { createVmSubnet }
            "B" { dabug }
            "Q" { Exit }
        }
    }
    until ($status -eq "Q")
}
mainMenu