require 'fileutils'
#fin = 'F:\\script\\9.11.0.2088_内存监测.txt'
#fout = 'F:\\script\\9.11.0.2088_内存监测_金岭国际大酒店.txt'


Dir.glob('E:/dworkspace/DevExpress/Source/**/*.inc'){|fin|
  #~ if File.directory?(fin) && (/E:\/dworkspace\/DevExpress\/(.*Sources)\/\.\./=~fin)then
    puts fin
    #~ puts '      <browsing path="$(DevExpress)\\' + $1 +'"/>'
  #~ end
  fout = fin+'t'
  
  FileUtils.copy(fin, 'E:/dworkspace/DevExpress/Lib/Res')
=begin  
  File.open(fin){|io|
    open(fout, "w"){ |o|
      while (line = io.gets) do
        if ((/(.*)<Directories Name="UnitOutputDir">.*<\\\/Directories>.*/ =~ line)!=nil) then
          o.write($1+'<Directories Name="UnitOutputDir">'+'$(DevExpress)\Lib\Dcu'+'</Directories>'+"\n")
        elsif ((/(.*)<Directories Name="PackageDLLOutputDir">.*<\\\/Directories>.*/ =~ line)!=nil) then
          o.write($1+'<Directories Name="PackageDLLOutputDir">'+'$(DevExpress)\Lib'+'</Directories>'+"\n")
        elsif ((/(.*)<Directories Name="PackageDCPOutputDir">.*<\\\/Directories>.*/ =~ line)!=nil) then
          o.write($1+'<Directories Name="PackageDCPOutputDir">'+'$(DevExpress)\Lib'+'</Directories>'+"\n")
        elsif ((/(.*)<Directories Name="SearchPath">.*<\\\/Directories>.*/ =~ line)!=nil) then
          o.write($1+'<Directories Name="SearchPath">'+'..\Sources'+'</Directories>'+"\n")
        else
          o.write(line)
        end
      end
    }
  }
  File.delete(fin)
  File.rename(fout, fin)
=end
}

#~ puts (/.*<Directories Name="UnitOutputDir"><\/Directories>.*/ =~ '<Directories Name="UnitOutputDir"></Directories>')
#~ puts (/\a"/ =~ 'a"')