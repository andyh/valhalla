require "erubis"

class Installer
  def initialize(template_name, extension_key)
    @template_locations = ["/Volumes/Work/Projects/Foxsoft/t3templates"]
    @template_name = template_name
    @extension_key = extension_key
  end
  
  def build
    if found_location = template_location_contains(@template_name)
      puts "Building #{found_location}"
      require "#{found_location}"
      include_name = @template_name.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
      instance_eval "extend #{include_name}"
      
      filelist = FileList.new(found_location.gsub("#{@template_name}","**/*")) do |fl|
          fl.exclude(found_location+'.rb')
      end
      
      destfilelist = filelist.clone
      
      destination_base = FileUtils.pwd
      source_base = found_location.sub("/#{@template_name}","")

      mappings.each_pair do |k,v|
        out = eval(v)
        destfilelist.sub!(k,out)
      end
      destfilelist.sub!(source_base,destination_base)
      
      filelist.each_index do |src|        
        if filelist[src][-4..-1]==".erb"
          
          # TODO sort out where to put this lot for access in erb templates
          ext_key = @extension_key
          project = "test project"
          generate_md5_values = "// md5 stuff"
          
          eruby = Erubis::Eruby.new
          input = File.read(filelist[src])
          output   = eruby.convert(input)
          new_filepath = destfilelist[src].gsub(".erb","")
          File.open(new_filepath,"w") do |fe|
            fe.write(eval(output))
          end
        else
          if File.directory?(filelist[src])
            FileUtils.mkdir destfilelist[src]
          else            
            FileUtils.copy filelist[src], destfilelist[src]
          end
        end        
      end       
    end
  end
  
  private
  
  def template_location_contains(template_name)
    @template_locations.each do |l|
      if File.exist?(l+"/"+@template_name)
        return l+"/"+@template_name+"/"+@template_name
      end
    end
    abort %{Template not found in any of the following locations:
- #{@template_locations.join("\n- ")}}    
  end
end