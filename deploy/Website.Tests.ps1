param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string] $HostName
)

Describe 'Toy Website' {
    It 'Serves pages over HTTPS' {
        $request = [System.Net.HttpWebRequest]::Create("https://$HostName/")
        $request.AllowAuthRedirect = $false
        $request.GetResponse().StatusCode |
            Should -Be 200 -Because "the website requires HTTPS"
    }

    It 'Does not serve pages over HTTP' {
        $request = [System.Net.HttpWebRequest]::Create("http://$HostName/")
        $request.AllowAuthRedirect = $false
        $request.GetResponse().StatusCode | 
            Should -BeGreaterOrEqual 300 -Because "HTTP is not secure"
    }
}