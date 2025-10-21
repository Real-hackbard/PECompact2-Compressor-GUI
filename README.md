# PECompact2-Compressor-GUI:

</br>

![Compiler](https://github.com/user-attachments/assets/a916143d-3f1b-4e1f-b1e0-1067ef9e0401) &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: ![10 Seattle](https://github.com/user-attachments/assets/c70b7f21-688a-4239-87c9-9a03a8ff25ab) ![10 1 Berlin](https://github.com/user-attachments/assets/bdcd48fc-9f09-4830-b82e-d38c20492362) ![10 2 Tokyo](https://github.com/user-attachments/assets/5bdb9f86-7f44-4f7e-aed2-dd08de170bd5) ![10 3 Rio](https://github.com/user-attachments/assets/e7d09817-54b6-4d71-a373-22ee179cd49c)   
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;![10 4 Sydney](https://github.com/user-attachments/assets/e75342ca-1e24-4a7e-8fe3-ce22f307d881) ![11 Alexandria](https://github.com/user-attachments/assets/64f150d0-286a-4edd-acab-9f77f92d68ad) ![12 Athens](https://github.com/user-attachments/assets/59700807-6abf-4e6d-9439-5dc70fc0ceca)  
![Components](https://github.com/user-attachments/assets/d6a7a7a4-f10e-4df1-9c4f-b4a1a8db7f0e) : ![None](https://github.com/user-attachments/assets/30ebe930-c928-4aaf-a8e1-5f68ec1ff349)  
![Discription](https://github.com/user-attachments/assets/4a778202-1072-463a-bfa3-842226e300af) &nbsp;&nbsp;: ![PECompact2 Compressor GUI](https://github.com/user-attachments/assets/b265f9f3-3d74-4789-89de-e9c9e8f39e9e)  
![Last Update](https://github.com/user-attachments/assets/e1d05f21-2a01-4ecf-94f3-b7bdff4d44dd) &nbsp;: ![102025](https://github.com/user-attachments/assets/62cea8cc-bd7d-49bd-b920-5590016735c0)  
![License](https://github.com/user-attachments/assets/ff71a38b-8813-4a79-8774-09a2f3893b48) &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: ![Freeware](https://github.com/user-attachments/assets/1fea2bbf-b296-4152-badd-e1cdae115c43)

</br>

![PECompact2](https://github.com/user-attachments/assets/3ba87070-b63d-45f5-b69e-7ba0b58ac0c0)

</br>

PECompact2 is a utility of the genre known as "executable packers". Executable packers compress executables and modules so that their physical size is considerably smaller than it originally was. At runtime, the module (executable) is decompressed and reconstructed in memory. With high-performance executable packers such as PECompact v2.x, decompression and reconstruction is so rapid that load time may actually improve since the time saved by reading fewer bytes from the disk or network may exceed the time spent reconstructing and decompressing the module.

</br>

![PECompact2 Compressor GUI](https://github.com/user-attachments/assets/287b0ce9-d821-490a-afa7-d43befc26727)

</br>


Typically, PECompact2 compresses modules substantially better than that of the common compression software such as RAR and ZIP. This is accomplished through advanced techniques of pre-processing a module to make it more compressible when passed to the compression algorithm. PECompact2 allows use of virtually any compression algorithm due to its CODEC plug-in support. Included compression algorithms are listed here.

</br>

![Console](https://github.com/user-attachments/assets/7866beaf-a3cc-4006-8abc-02f58b2da33b)

</br>

In addition to space savings, PECompact2 inherently makes it more difficult to reverse engineer your module(s). The compressed data is unreadable and not directly modifiable. PECompact2's default loader employs some basic anti-debugging code to aid in prevention of reverse engineering. In addition, PECompact2 supports Loader plug-ins. Therefore, third parties can create custom loaders after purchasing the loader SDK.

### Topics:
* [Overview](https://bitsum.com/docs/PECompact%20Documentation/00overview.htm)
* [Using the console application (pec2)](https://bitsum.com/docs/PECompact%20Documentation/01consoleapp.htm)
* [Using the Graphical User Interface (pec2gui)](https://bitsum.com/docs/PECompact%20Documentation/02gui.htm)
* [Options / Settings / Parameters](https://bitsum.com/docs/PECompact%20Documentation/030options.htm)
* [CODEC plug-ins](https://bitsum.com/docs/PECompact%20Documentation/03codecs.htm)
* [Loader plug-ins](https://bitsum.com/docs/PECompact%20Documentation/04loaders.htm)
* [.NET executable compression](https://bitsum.com/docs/PECompact%20Documentation/051dotnet.htm)
* [API Hook plug-ins](https://bitsum.com/docs/PECompact%20Documentation/050apihooks.htm)
* [PE Suite (console mode PE tools](https://bitsum.com/docs/PECompact%20Documentation/056PESuite.htm)
* [Misc. Information](https://bitsum.com/docs/PECompact%20Documentation/090misc.htm)
* [TLS Callbacks](https://bitsum.com/docs/PECompact%20Documentation/091tls.htm)
* [Licensing / Purchasing](https://bitsum.com/docs/PECompact%20Documentation/0A0licensing.htm)
* [Credits](https://bitsum.com/docs/PECompact%20Documentation/0B0credits.htm)
### Plug-in SDK Documentation:
* [CODEC Plug-ins](https://bitsum.com/docs/CODEC%20Plug-in%20SDK/Codec%20Host%20Module/CodecHostModule.htm)
* [API Hook Plug-in](https://bitsum.com/docs/API%20Hook%20Plug-in%20SDK/00overview.htm)

</br>

PECompact allows for use of third-party loaders. Loaders are the piece(s) of code attached to host modules that reconstructs and decodes the module at runtime.

```
pec2ldr_antidebug.dll  A loader with some anti-debug code.
pec2ldr_default.dll    The default loader for PECompact.
pec2ldr_debug.dll      For use when you must load your compressed module in a debugger. Other loaders will cause the debugger to make undesired breaks.
pec2ldr_ead.dll        Enhanced anti-debug loader. For select customers who purchase a license to use this frequently updated loader plug-in that offers enhanced protection against reverse-engineering.
pec2ldr_reduced.dll    A subset of the default loader. It does not contain code to handle import and other types of errors gracefully.
pec2ldr_trial.dll      Implements trial/evaluation version restrictions on the compressed application. [This loader not available at time of this writing]
```

</br>

A Loader SDK is available for purchase from Bitsum Technologies for those interested in developing their own custom PECompact loaders.

CODEC Ordering / Sequence:

The ordering use of CODECs is very important since it dramatically affects the output. For instance, you should always compression before encrypt, else the compression is likely to suffer a terrible penalty since the data was transformed into a much more random state by the encryption. The ordering of CODECs is as specified during compression and reversed during decompression. This means that the following configuration would perform a CRC check on the compressed data, there-by performing in at run-time before decompression:

```
pec2codec_ffce
pec2codec_crc32
Another example is the case of a password protected and compressed executable with crc32 validation, which should be in a similar order as follows:

pec2codec_ffce
pec2codec_password
pec2codec_crc32
Sometimes you may want to use a single CODEC multiple times, for instance:

pec2codec_crc32
pec2codec_ffce
pec2codec_crc32
This would perform a CRC32 check before and after decompression, making sure that the data supplied to the decompressor is unchanged and that your data is in its exact original state after decompression. Note that this will slightly slow load time, though perhaps not noticably, depending on the size of the data set(s). Typically speaking, such a configuration is redundant.
```

</br>

Since PECompact performs its own quick checksum, it is generally better to not use the CRC32 plug-in unless you really need good image validation.

Which CODEC should I use?

Selecting the appropriate CODEC depends on the size and contents module you are compressing. Often, PECompact can best optimize small files when aPLib, FFCE, or JCALG1 are used with their small decoders. Larger files are typically compressed better by LZMA. Since the additional size of the fast decoder is insignificant for larger files, it is recommended that the fast decoder be used in such cases. For smaller files, the small decoder often performs as well, or better, than the fast decoder.

When extremely fast decompression is desired as well as a good compression ratio, we recommend FFCE. It doesn't compress quite as tight as LZMA, but decompresses much more rapidly. FFCE is the default for executables under 100Kb.

You should experiment with various CODECs to determine which is appropriate for your application. Some algorithms may perform particularly well on specific data, but generally speaking, FFCE and LZMA are the two typically used.

_________

### CODEC Plugin(s)
A CODEC host is a module that provides the compression and decompression (or encoding and decoding) algorithms to PECompact. Any number of CODEC hosts may be used during compression. The order they are provided in is significant and is reversed during decompressing or decoding. The default value is "pec2codec_ffce.dll".	/CodecHost

```
/Ch	
/CodecHost:pec2codec_ffce.dll
/CodecHost:pec2codec_jcalg1.dll
/CodecHost:pec2codec_aplib.dll
/CodecHost:pec2codec_crc32.dll,pec2codec_lzma.dll
/CodecHost:@mycodecs.lst
/Ch:pec2codec_ffce.dll
```

</br>

### Code Integrity Check
The code integrity check is a quick runtime test on reconstructed code. A CRC32 codec is provided for full integrity checking and should be used instead of this switch. The default value is "Yes". Turning this option on will expand the loader by a few bytes.	/CodeIntegrityCheck
```
/CodeIntegrityCheck
/Cic	/CodeIntegrityCheck:Yes
/CodeIntegrityCheck:No
/Cic:Yes
```

</br>

### Compress Exports
The export table identifies what symbols are exposed to other modules. By relocating it, it may be processed without the module being decompressed. The default mode of "Auto" is recommended. The default mode is "auto". In this mode, exports of executables are compressed, but exports of DLLs and other modules are not.

```
/CompressExports
/Ce	/CompressExports:Yes
/CompressExports:No
/CompressExports:Auto
/Ce:Auto
```

</br>

### Compressible Resources
This option allows for specification of resources that should be compressed. By default, all are compressed except the first group icon and icons it references, version, and manifest resources. For a list of resource type names, run the console application with no command line switches and select the 'R' option.

```
/CompressibleRT:@list
/CompressibleRT:typename1,typename2,...
or
/CompressibleRT:typeid#1,typeid#2,...
or
/CompressibleRT:namedrsrc1,namedrsrc2

(combinations of names, type names, type ids, and list files are supported).	/CompressibleRT:@myrsrc.txt
/CompressibleRT:groupicon,version
/CompressibleRT:4,5,1,namedresource,version
```

</br>

### Compression Level
(Global Decoder Options)	Some codecs support a compression level. The higher the level, the better, but slower, is the compression. Decompression speed is generally unaffected by the compression level.
The LZMA codec is an exception in that the compression level adjusts parameters that perform differently on different data sets. Therefore, the compression may be better at various levels, not necessarily the highest. The default value is "7".	

```
/CompressionLevel
or
/Cl
/CompressionLevel:1
/CompressionLevel:9
/Cl:8
```

</br>

### Enable Memory Protection
Prior to compression, an executable's sections are often set to restrict write access to their virtual memory. Enabling this option causes PECompact to restore the virtual memory access rights at runtime. The default is not to restore the memory access rights. Turning this option on will expand the loader by approximately 50 bytes.	

```
/EnableMemoryProtection
or
/Emp
/EnableMemoryProtection:Yes
/EnableMemoryProtection:No
/Emp:No
```

</br>

These are some examples of how the codecs are used to modify the code. For further codec examples, see the documentation on the website.

### Update:
To update the program, you can simply overwrite the "PECompact2.exe" located in the "Drivers" folder.
```
..\Drivers\PECompact2.exe
```

