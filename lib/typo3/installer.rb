require "erubis"

class Installer
  def initialize(template_name, extension_key)
    @template_locations = ["/Volumes/Work/Projects/Foxsoft/t3templates"]
    @template_name = template_name
    @extension_key = extension_key
  end
  
  def build
    if found_location = template_location_contains(@template_name)
      puts "Would be building #{found_location}"
      require "#{found_location}"
      include_name = @template_name.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
      instance_eval "extend #{include_name}"
      
      filelist = FileList.new(found_location.gsub("#{@template_name}","**/*")) do |fl|
          fl.exclude(found_location+'.rb')
      end
      
      # puts "In location #{FileUtils.pwd}"
      destination_base = FileUtils.pwd
      source_base = found_location.sub("/#{@template_name}","")
      # puts "Source Base:"+source_base
      filelist.each do |src|
        if src[-4..-1]==".erb"
          
          # TODO sort out where to put this lot for access in erb templates
          ext_key = @extension_key
          project = "test project"
          generate_md5_values = "md5 stuff"
          
          eruby = Erubis::Eruby.new
          input = File.read(src)
          output   = eruby.convert(input)
          new_filepath = destination_base+src.gsub(source_base,"").gsub(".erb","")
          puts new_filepath
          File.open(new_filepath,"w") do |fe|
            fe.write(eval output)
          end
        else
          if File.directory?(src)
            FileUtils.mkdir destination_base+src.sub(source_base,"")
          else
            FileUtils.copy src, destination_base+src.sub(source_base,"")        
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