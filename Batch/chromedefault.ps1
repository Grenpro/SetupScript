# Path to XML file with default app associations
$xmlPath = "defaultassociations.xml"

# Apply the default app associations
Dism /Online /Import-DefaultAppAssociations:$xmlPath
