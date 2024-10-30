# Path to XML file with default app associations
$xmlPath = "C:\Users\Public\Startupscript\batch\defaultassociations.xml"

# Apply the default app associations
Dism /Online /Import-DefaultAppAssociations:$xmlPath
