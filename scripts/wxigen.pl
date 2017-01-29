#****************************************************************************
#* wxigen.pl
#****************************************************************************
use File::Basename;

$rootDir = $ARGV[0];
$outFile = $ARGV[1];
@componentIds;

print("Generating $outFile ...\n");

open(f, "> $outFile");
print(f "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n");
print(f "<Include>\n");
print(f "  <Directory Id=\"TARGETDIR\" Name=\"SourceDir\">\n");
print(f "    <Directory Id=\"ProgramMenuFolder\">\n");
print(f "      <Directory Id=\"ApplicationProgramsFolder\" Name=\"DVKit_\$(var.version)\"/>\n");
print(f "    </Directory>\n");
print(f "    <Directory Id=\"\$(var.ProgramFilesFolder)\" Name=\"PFiles\">\n");
print(f "      <Directory Id=\"DVKit\" Name=\"DVKit\">\n");
print(f "        <Directory Id=\"INSTALLDIR\" Name=\"DVKit_\$(var.version)\">\n");
getDirTree($rootDir, 1);
# f.Write(getDirTree(rootDir, "", 1, baseFolder, componentIds));
print(f "        </Directory>\n");
print(f "      </Directory>\n");
print(f "    </Directory>\n");
print(f "  </Directory>\n");
print(f "  <Feature Id=\"DefaultFeature\" Level=\"1\" ConfigurableDirectory=\"TARGETDIR\">\n");
for ($i=0; $i<=$#componentIds; $i++) {
    $componentId=$componentIds[$i];
    print(f "    <ComponentRef Id=\"C__${componentId}\" />\n");
}
print(f "  </Feature>\n");
print(f "</Include>\n");
close(f);

# recursive method to extract information for a folder
# root, xml, indent, baseFolder, componentIds
# root, indent
sub getDirTree($;$) {
  my($root,$indent) = @_;
  my($fdrFolder,$space,$directoryId,$componentGuid,$componentId);
  my($id,$name);
  my($DIR);
  my($first) = 1;

    # indent the xml
  $space = "";
  for ($i=0; $i<$indent; $i++) {
    $space .= "  ";
  }

  unless ($root eq $rootDir) {
    $directoryId = "_" . FlatFormat(GetGuid());
    $name = basename($root);

    print(f "$space<Directory Id=\"$directoryId\" Name=\"$name\">\n");
  }

  $componentGuid = GetGuid();
  $componentId = FlatFormat($componentGuid);

  opendir($DIR, $root);

  while (my $file = readdir($DIR)) {
    if (-f "$root/$file") {
      if ($first == 1) {
        print(f "$space  <Component Id=\"C__${componentId}\" Guid=\"${componentGuid}\" Win64=\"\$(var.Win64)\">\n");
        $first = 0;
      }

      $name = $file;
      $file = "$root/$file";
      $id = MkId($name);
      print(f "$space    <File DiskId=\"1\" Id=\"$id\" Name=\"${name}\" Source=\"z:${file}\"/>\n");
    }
  }

  if ($first == 0) {
    print(f "$space  </Component>\n");
    push(@componentIds, $componentId);
  }

  closedir($DIR);

  opendir($DIR, $root);
  while (my $file = readdir($DIR)) {
    if (-d "$root/$file") {
      unless($file eq "." || $file eq "..") {
        getDirTree("$root/$file", $indent + 1);
      }
    }
  }
  closedir($DIR);

  unless ($root eq $rootDir) {
    print(f "${space}</Directory>\n");
  }
}

sub GetGuid() {
  my(@itoh) = ("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F");
  my(@n,@s);
  my($tmp);
  
  # Make array of random hex digits. The UUID only has 32 digits in it, but we
  # allocate an extra items to make room for the '-'s we'll be inserting.
  for ($i=0; $i<36; $i++) {
    $tmp = int(rand(16));
    push(@n, $tmp);
  }
 
  # Conform to RFC-4122, section 4.4
  $n[14] = "4";  # Set 4 high bits of time_high field to version
  $n[19] = ($n[19] & 0x3) | 0x8;  # Specify 2 high bits of clock sequence
 
  # Convert to hex chars
  for ($i=0; $i<36; $i++) {
    push(@s, $itoh[$n[$i]]);
  } 
 
  # Insert '-'s
  $s[8] = '-';
  $s[13] = '-';
  $s[18] = '-';
  $s[23] = '-';
  
  return join("", @s);
}

# Convert a GUID from this format
#   7e70e5e5-ce19-4270-a740-223a09796433
# to this format:
#   7E70E5E5CE194270A740223A09796433
sub FlatFormat($) {
  my($guid) = @_;

  $guid =~ s/-//g;

  return $guid;
}

sub MkId($) {
  my($name) = @_;
  
  return "I_" . FlatFormat(GetGuid());
}

