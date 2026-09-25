# -*- coding: utf-8 -*-
"""Pack TokenVector.Plot.1.0.1.nupkg with icon and README."""
import io, os, shutil, zipfile

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
os.chdir(BASE_DIR)
STAGE = r'C:\Users\Admin\AppData\Local\Temp\opencode\nupkg_plot'
shutil.rmtree(STAGE, ignore_errors=True)
os.makedirs(os.path.join(STAGE, '_rels'), exist_ok=True)
os.makedirs(os.path.join(STAGE, 'lib', 'net8.0'), exist_ok=True)
os.makedirs(os.path.join(STAGE, 'package', 'services', 'metadata', 'core-properties'), exist_ok=True)

# Standard rels & content types template
zref = zipfile.ZipFile(r'D:\TokenVector.Data\packages\TokenVector.Data.1.0.9.nupkg')
rels = zref.read('_rels/.rels')
ct = zref.read('[Content_Types].xml')
zref.close()

readme = io.open('README.md', 'rb').read()
logo_bytes = io.open('logo.png', 'rb').read()

desc = ('High-performance publication-quality scientific visualization and plotting library '
        'natively implemented in the TokenVector language (tkv) and compiled to a .NET CIL DLL: '
        'line plots, scatter charts, bar histograms, 2D matrix heatmaps, box plots, scientific styling themes, '
        'colormaps, coordinate transforms, and vector SVG rendering.')

psmdcp = ('<?xml version="1.0" encoding="utf-8"?>\r\n'
          '<coreProperties xmlns:dc="http://purl.org/dc/elements/1.1/" '
          'xmlns:dcterms="http://purl.org/dc/terms/" '
          'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" '
          'xmlns="http://schemas.openxmlformats.org/package/2006/metadata/core-properties">\r\n'
          '  <dc:creator>TokenVector Project Team</dc:creator>\r\n'
          '  <dc:description>' + desc + '</dc:description>\r\n'
          '  <dc:identifier>TokenVector.Plot</dc:identifier>\r\n'
          '  <version>1.0.1</version>\r\n'
          '  <keywords>plot plotting visualization graphics svg charts scientific publication tokenvector</keywords>\r\n'
          '  <lastModifiedBy>NuGet, Version=7.9.0.83, Culture=neutral, PublicKeyToken=31bf3856ad364e35;'
          'Microsoft Windows NT 10.0.19045.0;.NET Framework 4.7.2</lastModifiedBy>\r\n'
          '</coreProperties>')

def w(rel, data):
    p = os.path.join(STAGE, *rel.split('/'))
    if isinstance(data, str):
        io.open(p, 'w', encoding='utf-8', newline='').write(data)
    else:
        io.open(p, 'wb').write(data)

w('_rels/.rels', rels)
w('[Content_Types].xml', ct)
w('README.md', readme)
w('logo.png', logo_bytes)
w('package/services/metadata/core-properties/nuget.psmdcp', psmdcp)
nuspec = io.open('tvsrc/package/TokenVector.Plot.nuspec', encoding='utf-8').read()
w('TokenVector.Plot.nuspec', nuspec)
shutil.copyfile('tvsrc/TokenVector.Plot.dll',
                os.path.join(STAGE, 'lib', 'net8.0', 'TokenVector.Plot.dll'))

os.makedirs('packages', exist_ok=True)
out = 'packages/TokenVector.Plot.1.0.1.nupkg'
if os.path.exists(out):
    os.remove(out)
with zipfile.ZipFile(out, 'w', zipfile.ZIP_DEFLATED) as z:
    for root, _, files in os.walk(STAGE):
        for f in files:
            full = os.path.join(root, f)
            arc = os.path.relpath(full, STAGE).replace(os.sep, '/')
            z.write(full, arc)
print('packed:', out, os.path.getsize(out), 'bytes')
with zipfile.ZipFile(out) as z:
    print('Contents in nupkg:')
    for item in z.namelist():
        print(' -', item)
