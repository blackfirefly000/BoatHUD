--Endable or disable the version checker. Accepted values: true, false
local VersionChecker = true

--DON'T EDIT BELOW THIS LINE


if VersionChecker then
  local current = GetResourceMetadata(GetCurrentResourceName(), 'version')
  local github = "https://raw.githubusercontent.com/blackfirefly000/BoatHUD/main/version"

  function checkVersion(current)
      PerformHttpRequest(github, function(statusCode, data, headers)
          if statusCode == 200 then
              local latest = data:match("%s*(.-)%s(.-)%s*$")  -- Trim whitespace
              print(
                [[
________             ___________  ______  _________ 
___  __ )___________ __  /___  / / /_  / / /__  __ \
__  __  |  __ \  __ `/  __/_  /_/ /_  / / /__  / / /
_  /_/ // /_/ / /_/ // /_ _  __  / / /_/ / _  /_/ / 
/_____/ \____/\__,_/ \__/ /_/ /_/  \____/  /_____/         
                  By Blackfirefly000
                ]])
              print("Installed Version: " .. current)
              print("Latest Version: " .. latest)
              if current == latest then
                  print("^2BoatHUD is up to date.")
              else
                  print("^1BoatHUD is out of date. A newer version is available at ^5https://github.com/blackfirefly000/BoatHUD/releases")
              end
          else
              print("^3Error fetching version:", statusCode)
          end
      end, "GET", "", { ["Content-Type"] = "application/json" })
  end

  checkVersion(current)

end