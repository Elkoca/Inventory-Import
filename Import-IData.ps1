function Import-IProductTypeData {
    [CmdletBinding()]
    param (
        [Parameter(mandatory = $true)]
        [string]
        $BaseUri, #https://localhost:7156/api/

        [Parameter(mandatory = $true)]
        [string]
        $JsonFilePath # ".\Data\ProductType.json"
    )
    
    begin {
        $ProductTypeUri = $BaseUri + "ProductTypes/"
    }
    
    process {
        $data = Get-Content -Path $JsonFilePath | ConvertFrom-Json

        foreach ($obj in $data){
            $thisUri = $ProductTypeUri + $obj.productTypeId
            $body = $obj | ConvertTo-Json
            Invoke-RestMethod -Uri $thisUri -method Put -Body $body -ContentType "application/json"
        }
    }
    end {
        
    }
}

function Import-IVendorData {
    [CmdletBinding()]
    param (
        [Parameter(mandatory = $true)]
        [string]
        $BaseUri, #https://localhost:7156/api/

        [Parameter(mandatory = $true)]
        [string]
        $JsonFilePath # ".\Data\Vendor.json"
    )
    
    begin {
        $VendorUri = $BaseUri + "Vendors/"
    }
    
    process {
        $data = Get-Content -Path $JsonFilePath | ConvertFrom-Json

        foreach ($obj in $data){
            $thisUri = $VendorUri + $obj.vendorId
            $body = $obj | ConvertTo-Json
            Invoke-RestMethod -Uri $thisUri -method Put -Body $body -ContentType "application/json"
        }
    }
    end {
        
    }
}

function Import-IProductData {
    [CmdletBinding()]
    param (
        [Parameter(mandatory = $true)]
        [string]
        $BaseUri, #https://localhost:7156/api/

        [Parameter(mandatory = $true)]
        [string]
        $JsonFilePath # ".\Data\Product.json"
    )
    
    begin {
        $ProductUri = $BaseUri + "Products/"
    }
    
    process {
        $data = Get-Content -Path $JsonFilePath | ConvertFrom-Json

        foreach ($obj in $data){
            $thisUri = $ProductUri + $obj.productId
            $body = $obj | ConvertTo-Json
            Invoke-RestMethod -Uri $thisUri -method Put -Body $body -ContentType "application/json"
        }
    }
    end {
        
    }
}

function Import-IData {
    [CmdletBinding()]
    param (
        [Parameter(mandatory = $true)]
        [string]
        $BaseUri,

        [Parameter(mandatory = $false)]
        [string]
        $VendorJsonFilePath = ".\Data\Vendor.json",

        [Parameter(mandatory = $false)]
        [string]
        $ProductTypeJsonFilePath = ".\Data\ProductType.json",

        [Parameter(mandatory = $false)]
        [string]
        $ProductJsonFilePath = ".\Data\Product.json"
    )
    
    begin {
        $BaseUri = $BaseUri.trim()
        if(!$BaseUri.EndsWith("/")){
            $BaseUri = $BaseUri + "/"
        }
    }
    
    process {
        $Vendors = Import-IVendorData -BaseUri $BaseUri -JsonFilePath $VendorJsonFilePath
        $ProductTypes = Import-IProductTypeData -BaseUri $BaseUri -JsonFilePath $ProductTypeJsonFilePath
        $Products = Import-IProductData -BaseUri $BaseUri -JsonFilePath $ProductJsonFilePath
        
        #Output does not work on put
        # $output = [PSCustomObject]@{
        #     Vendors = $Vendors
        #     ProductTypes = $ProductTypes
        #     Products = $Products
        # }

        # Write-Output $output
    }
    
    end {
        
    }
}

Import-IData -BaseUri "https://localhost:7156/api"
