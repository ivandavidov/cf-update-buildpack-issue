This repository provides the resources to automatically reproduce the [CF CLI](https://github.com/cloudfoundry/cli) issue [Uploaded buildpack stack (cflinuxfs3) does not match cflinuxfs3](https://github.com/cloudfoundry/cli/issues/1518) which I submitted there just recently.

To reproduce the issue simply run the ``./updateBuildpackFail.sh`` script. Note that the key element to successfully reproduce the issue is to have a [manifest.yml](https://github.com/ivandavidov/cf-update-buildpack-issue/blob/master/dummy_buildpack/manifest.yml) file in which the CF Linux FS stack has to be specified.

Even though it is obvious, the _dummy buildpack_ is really dummy. It has properly defined buildpack structure but the buildpack itself does nothing (literally). The only purpose for the existence of this buildpack is to demonstrate the issue with the ``cf update-buildpack`` command.

The output below is the same as in the [output_without_debug.txt](https://github.com/ivandavidov/cf-update-buildpack-issue/blob/master/output_without_debug.txt) file from my own test environment.

---

```
apama@vmbgcloudf06:~/Downloads/ivan/cf-update-buildpack-issue$ ./updateBuildpackFail.sh
+ cf --version
cf version 6.41.0+dd4c76cdd.2018-11-28
++ cf buildpacks
++ grep 'dummy_buildpack.*cflinuxfs2'
+ '[' '' ']'
++ cf buildpacks
++ grep 'dummy_buildpack.*cflinuxfs3'
+ '[' '' ']'
+ sed -i 's|\(.*\)cflinuxfs.*|\1cflinuxfs2|g' dummy_buildpack/manifest.yml
+ cat dummy_buildpack/manifest.yml
---
stack:
  - cflinuxfs2
+ cf create-buildpack dummy_buildpack dummy_buildpack/ 1
Creating buildpack dummy_buildpack as admin...
OK

Uploading buildpack dummy_buildpack as admin...
 836 B / 836 B [=================================================================================================================================================================================] 100.00% 1s

Done uploading
OK
+ cf buildpacks
Getting buildpacks...

buildpack               position   enabled   locked   filename                                      stack
dummy_buildpack         1          true      false    dummy_buildpack.zip                           cflinuxfs2
staticfile_buildpack    2          true      false    staticfile-buildpack-cflinuxfs3-v1.4.35.zip   cflinuxfs3
staticfile_buildpack    3          true      false    staticfile-buildpack-cflinuxfs2-v1.4.35.zip   cflinuxfs2
binary_buildpack        4          true      false    binary-buildpack-cflinuxfs2-v1.0.27.zip       cflinuxfs2
java_buildpack          5          true      false    java-buildpack-cflinuxfs2-v4.16.1.zip         cflinuxfs2
java_buildpack          6          true      false    java-buildpack-cflinuxfs3-v4.16.1.zip         cflinuxfs3
ruby_buildpack          7          true      false    ruby-buildpack-cflinuxfs2-v1.7.27.zip         cflinuxfs2
ruby_buildpack          8          true      false    ruby-buildpack-cflinuxfs3-v1.7.27.zip         cflinuxfs3
dotnet_core_buildpack   9          true      false    dotnet-core-buildpack-cflinuxfs2-v2.2.0.zip   cflinuxfs2
dotnet_core_buildpack   10         true      false    dotnet-core-buildpack-cflinuxfs3-v2.2.0.zip   cflinuxfs3
nodejs_buildpack        11         true      false    nodejs-buildpack-cflinuxfs2-v1.6.34.zip       cflinuxfs2
nodejs_buildpack        12         true      false    nodejs-buildpack-cflinuxfs3-v1.6.34.zip       cflinuxfs3
go_buildpack            13         true      false    go-buildpack-cflinuxfs2-v1.8.29.zip           cflinuxfs2
go_buildpack            14         true      false    go-buildpack-cflinuxfs3-v1.8.29.zip           cflinuxfs3
python_buildpack        15         true      false    python-buildpack-cflinuxfs2-v1.6.23.zip       cflinuxfs2
python_buildpack        16         true      false    python-buildpack-cflinuxfs3-v1.6.23.zip       cflinuxfs3
php_buildpack           17         true      false    php-buildpack-cflinuxfs2-v4.3.64.zip          cflinuxfs2
php_buildpack           18         true      false    php-buildpack-cflinuxfs3-v4.3.64.zip          cflinuxfs3
binary_buildpack        19         true      false    binary-buildpack-cflinuxfs3-v1.0.27.zip       cflinuxfs3
+ sed -i 's|\(.*\)cflinuxfs.*|\1cflinuxfs3|g' dummy_buildpack/manifest.yml
+ cat dummy_buildpack/manifest.yml
---
stack:
  - cflinuxfs3
+ cf create-buildpack dummy_buildpack dummy_buildpack/ 1
Creating buildpack dummy_buildpack as admin...
OK

Uploading buildpack dummy_buildpack as admin...
 836 B / 836 B [==================================================================================] 100.00% 1s

Done uploading
OK
+ cf buildpacks
Getting buildpacks...

buildpack               position   enabled   locked   filename                                      stack
dummy_buildpack         1          true      false    dummy_buildpack.zip                           cflinuxfs3
dummy_buildpack         2          true      false    dummy_buildpack.zip                           cflinuxfs2
staticfile_buildpack    3          true      false    staticfile-buildpack-cflinuxfs3-v1.4.35.zip   cflinuxfs3
staticfile_buildpack    4          true      false    staticfile-buildpack-cflinuxfs2-v1.4.35.zip   cflinuxfs2
binary_buildpack        5          true      false    binary-buildpack-cflinuxfs2-v1.0.27.zip       cflinuxfs2
java_buildpack          6          true      false    java-buildpack-cflinuxfs2-v4.16.1.zip         cflinuxfs2
java_buildpack          7          true      false    java-buildpack-cflinuxfs3-v4.16.1.zip         cflinuxfs3
ruby_buildpack          8          true      false    ruby-buildpack-cflinuxfs2-v1.7.27.zip         cflinuxfs2
ruby_buildpack          9          true      false    ruby-buildpack-cflinuxfs3-v1.7.27.zip         cflinuxfs3
dotnet_core_buildpack   10         true      false    dotnet-core-buildpack-cflinuxfs2-v2.2.0.zip   cflinuxfs2
dotnet_core_buildpack   11         true      false    dotnet-core-buildpack-cflinuxfs3-v2.2.0.zip   cflinuxfs3
nodejs_buildpack        12         true      false    nodejs-buildpack-cflinuxfs2-v1.6.34.zip       cflinuxfs2
nodejs_buildpack        13         true      false    nodejs-buildpack-cflinuxfs3-v1.6.34.zip       cflinuxfs3
go_buildpack            14         true      false    go-buildpack-cflinuxfs2-v1.8.29.zip           cflinuxfs2
go_buildpack            15         true      false    go-buildpack-cflinuxfs3-v1.8.29.zip           cflinuxfs3
python_buildpack        16         true      false    python-buildpack-cflinuxfs2-v1.6.23.zip       cflinuxfs2
python_buildpack        17         true      false    python-buildpack-cflinuxfs3-v1.6.23.zip       cflinuxfs3
php_buildpack           18         true      false    php-buildpack-cflinuxfs2-v4.3.64.zip          cflinuxfs2
php_buildpack           19         true      false    php-buildpack-cflinuxfs3-v4.3.64.zip          cflinuxfs3
binary_buildpack        20         true      false    binary-buildpack-cflinuxfs3-v1.0.27.zip       cflinuxfs3
+ sed -i 's|\(.*\)cflinuxfs.*|\1cflinuxfs2|g' dummy_buildpack/manifest.yml
+ cat dummy_buildpack/manifest.yml
---
stack:
  - cflinuxfs2
+ cf update-buildpack dummy_buildpack -p dummy_buildpack -s cflinuxfs2
Updating buildpack dummy_buildpack with stack cflinuxfs2 as admin...
OK
Uploading buildpack dummy_buildpack as admin...
 0 B / 836 B [---------------------------------------------------------------------------------------]   0.00%
Uploaded buildpack stack (cflinuxfs2) does not match cflinuxfs2
FAILED
+ cf buildpacks
Getting buildpacks...

buildpack               position   enabled   locked   filename                                      stack
dummy_buildpack         1          true      false    dummy_buildpack.zip                           cflinuxfs3
dummy_buildpack         2          true      false    dummy_buildpack.zip                           cflinuxfs2
staticfile_buildpack    3          true      false    staticfile-buildpack-cflinuxfs3-v1.4.35.zip   cflinuxfs3
staticfile_buildpack    4          true      false    staticfile-buildpack-cflinuxfs2-v1.4.35.zip   cflinuxfs2
binary_buildpack        5          true      false    binary-buildpack-cflinuxfs2-v1.0.27.zip       cflinuxfs2
java_buildpack          6          true      false    java-buildpack-cflinuxfs2-v4.16.1.zip         cflinuxfs2
java_buildpack          7          true      false    java-buildpack-cflinuxfs3-v4.16.1.zip         cflinuxfs3
ruby_buildpack          8          true      false    ruby-buildpack-cflinuxfs2-v1.7.27.zip         cflinuxfs2
ruby_buildpack          9          true      false    ruby-buildpack-cflinuxfs3-v1.7.27.zip         cflinuxfs3
dotnet_core_buildpack   10         true      false    dotnet-core-buildpack-cflinuxfs2-v2.2.0.zip   cflinuxfs2
dotnet_core_buildpack   11         true      false    dotnet-core-buildpack-cflinuxfs3-v2.2.0.zip   cflinuxfs3
nodejs_buildpack        12         true      false    nodejs-buildpack-cflinuxfs2-v1.6.34.zip       cflinuxfs2
nodejs_buildpack        13         true      false    nodejs-buildpack-cflinuxfs3-v1.6.34.zip       cflinuxfs3
go_buildpack            14         true      false    go-buildpack-cflinuxfs2-v1.8.29.zip           cflinuxfs2
go_buildpack            15         true      false    go-buildpack-cflinuxfs3-v1.8.29.zip           cflinuxfs3
python_buildpack        16         true      false    python-buildpack-cflinuxfs2-v1.6.23.zip       cflinuxfs2
python_buildpack        17         true      false    python-buildpack-cflinuxfs3-v1.6.23.zip       cflinuxfs3
php_buildpack           18         true      false    php-buildpack-cflinuxfs2-v4.3.64.zip          cflinuxfs2
php_buildpack           19         true      false    php-buildpack-cflinuxfs3-v4.3.64.zip          cflinuxfs3
binary_buildpack        20         true      false    binary-buildpack-cflinuxfs3-v1.0.27.zip       cflinuxfs3
+ sed -i 's|\(.*\)cflinuxfs.*|\1cflinuxfs3|g' dummy_buildpack/manifest.yml
+ cat dummy_buildpack/manifest.yml
---
stack:
  - cflinuxfs3
+ cf update-buildpack dummy_buildpack -p dummy_buildpack -s cflinuxfs3
Updating buildpack dummy_buildpack with stack cflinuxfs3 as admin...
OK
Uploading buildpack dummy_buildpack as admin...
 0 B / 836 B [---------------------------------------------------------------------------------------]   0.00%
Uploaded buildpack stack (cflinuxfs3) does not match cflinuxfs3
FAILED
+ cf buildpacks
Getting buildpacks...

buildpack               position   enabled   locked   filename                                      stack
dummy_buildpack         1          true      false    dummy_buildpack.zip                           cflinuxfs3
dummy_buildpack         2          true      false    dummy_buildpack.zip                           cflinuxfs2
staticfile_buildpack    3          true      false    staticfile-buildpack-cflinuxfs3-v1.4.35.zip   cflinuxfs3
staticfile_buildpack    4          true      false    staticfile-buildpack-cflinuxfs2-v1.4.35.zip   cflinuxfs2
binary_buildpack        5          true      false    binary-buildpack-cflinuxfs2-v1.0.27.zip       cflinuxfs2
java_buildpack          6          true      false    java-buildpack-cflinuxfs2-v4.16.1.zip         cflinuxfs2
java_buildpack          7          true      false    java-buildpack-cflinuxfs3-v4.16.1.zip         cflinuxfs3
ruby_buildpack          8          true      false    ruby-buildpack-cflinuxfs2-v1.7.27.zip         cflinuxfs2
ruby_buildpack          9          true      false    ruby-buildpack-cflinuxfs3-v1.7.27.zip         cflinuxfs3
dotnet_core_buildpack   10         true      false    dotnet-core-buildpack-cflinuxfs2-v2.2.0.zip   cflinuxfs2
dotnet_core_buildpack   11         true      false    dotnet-core-buildpack-cflinuxfs3-v2.2.0.zip   cflinuxfs3
nodejs_buildpack        12         true      false    nodejs-buildpack-cflinuxfs2-v1.6.34.zip       cflinuxfs2
nodejs_buildpack        13         true      false    nodejs-buildpack-cflinuxfs3-v1.6.34.zip       cflinuxfs3
go_buildpack            14         true      false    go-buildpack-cflinuxfs2-v1.8.29.zip           cflinuxfs2
go_buildpack            15         true      false    go-buildpack-cflinuxfs3-v1.8.29.zip           cflinuxfs3
python_buildpack        16         true      false    python-buildpack-cflinuxfs2-v1.6.23.zip       cflinuxfs2
python_buildpack        17         true      false    python-buildpack-cflinuxfs3-v1.6.23.zip       cflinuxfs3
php_buildpack           18         true      false    php-buildpack-cflinuxfs2-v4.3.64.zip          cflinuxfs2
php_buildpack           19         true      false    php-buildpack-cflinuxfs3-v4.3.64.zip          cflinuxfs3
binary_buildpack        20         true      false    binary-buildpack-cflinuxfs3-v1.0.27.zip       cflinuxfs3
apama@vmbgcloudf06:~/Downloads/ivan/cf-update-buildpack-issue$
```
