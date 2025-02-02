Function global:DockerBinding {

    Param(
        [Parameter(Mandatory = $true, Position = 0)]
        [String]
        $Cmd,
          
        [Parameter(Mandatory = $false, ValueFromRemainingArguments = $true)]
        [String[]]
        $Params
    )

    Switch ($Cmd) 
    {
        # list containers
        'c' { docker container ps $Params }
        # stop container
        'cx' { docker container stop $Params }
        # start container
        'cs' { docker container start $Params }
        # remove container
        'cr' { docker container rm $Params }

        
        # list images
        'i' { docker image ls $Params }
        # tag image
        'it' { docker image tag $Params }
        # remove image
        'ir' { docker image rm $Params }

        # build
        'b' { docker build $Params }
        # push
        'p' { docker push $Params }

    }
}

Function global:GitBinding {

    Param(
        [Parameter(Mandatory = $true, Position = 0)]
        [String]
        $Cmd,
          
        [Parameter(Mandatory = $false, ValueFromRemainingArguments = $true)]
        [String[]]
        $Params
    )

    Switch ($Cmd) 
    {
        # status
        's' { git status $Params }
        # tag
        't' { git tag $Params }
        # commit
        'c' { git commit $Params }
        # clone repo
        'cl' { git clone $Params }
        # reset changes
        'r' { git reset $Params }
        # merge
        'm' { git merge $Params }
        # push
        'ps' { git push $Params }
        # pull
        'pl' { git pull $Params }

    }
}

# Opens the Windows hosts file in VS code.
function hosts {
    code "C:\Windows\System32\drivers\etc\hosts"
}

# BEGIN POWERSHELL RELOAD
# Powershell reload is based on code from this article by Øyvind Kallstad. -> https://communary.net/2015/05/28/how-to-reload-the-powershell-console-session/
# Restarts PowerShell in-place. Useful in the event you have added something to the path or user profile script and need a powershell restart in order for it to be recognized.
function Invoke-PowerShell {
    powershell -nologo
    Invoke-PowerShell
}

function Restart-PowerShell {
    if ($host.Name -eq 'ConsoleHost') {
        exit
    }
    Write-Warning 'Only usable while in the PowerShell console host'
}

# This code breaks the powershell reload infinite loop, so it's not calling itself forever.
$parentProcessId = (Get-WmiObject Win32_Process -Filter "ProcessId=$PID").ParentProcessId
$parentProcessName = (Get-WmiObject Win32_Process -Filter "ProcessId=$parentProcessId").ProcessName

if ($host.Name -eq 'ConsoleHost') {
    if (-not($parentProcessName -eq 'powershell.exe')) {
        Invoke-PowerShell
    }
}
# END POWERSHELL RELOAD

Set-Alias -Name 'reload' -Value 'Restart-PowerShell'
New-Alias d global:DockerBinding
New-Alias g global:GitBinding