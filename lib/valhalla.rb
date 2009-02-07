require "typo3/installer"

class Typo3
  attr_reader :sitename,:username, :password, :host, :dbname, :install_password
  
  def initialize
    get_TYPO3_details
    
    # look at somehow making this more automatically specific to environment
    @port = 3306
    
    @socket = `locate -l 1 mysql.sock`.to_s.strip
  end
  
  def show_config
    config = %{
  TYPO3 Sitename: #{@sitename}
    DB Username: #{@username}
    DB Password: #{@password}
    DB Host: #{@host}
    DB Name: #{@dbname}
    Install Tool: #{@install_password}
  }

    print config
  end

  def with_db
    dbh = Mysql.real_connect(self.host,self.username,self.password,self.dbname,@port,@socket)

    begin
      yield dbh
    ensure
      dbh.close
    end
  end

  def clear_cache(type)
    case type.to_sym
    when :all
      clear_pages
      clear_temp
      puts "Cleared All"
    when :page
      clear_pages
      puts "Cleared Pages"
    when :temp
      clear_temp
      puts "Cleared Temp"
    end
    
  end
  
  private
  
  def clear_pages
    self.with_db do |db|
      db.query('delete from cache_pagesection')
      db.query('delete from cache_hash')
    end
  end
  
  def clear_temp
    temp = FileList['**/temp_CACHED*.php']
    puts "hi"
    rm temp
  end
  
  def get_TYPO3_details
    localconf = FileList['**/localconf.php']

    localconf.each do |t|
        conf = IO.read(t)
        @sitename         = conf.scan(/\$TYPO3_CONF_VARS\[\'SYS\'\]\[\'sitename\'\]\s+=\s+\'(.*)\'\;/).last.to_s ||= ''
        @username         = conf.scan(/\$typo_db_username\s+=\s+\'(.*)\'\;/).last.to_s ||= ''
        @password         = conf.scan(/\$typo_db_password\s+=\s+\'(.*)\'\;/).last.to_s ||= ''
        @host             = conf.scan(/\$typo_db_host\s+=\s+\'(.*)\'\;/).last.to_s ||= ''
        @dbname           = conf.scan(/\$typo_db\s+=\s+\'(.*)\'\;/).last.to_s ||= ''
        @install_password = conf.scan(/\$TYPO3_CONF_VARS\[\'BE\'\]\[\'installToolPassword\'\]\s+=\s+\'(.*)\'\;/).last.to_s ||= ''
    end
    
  end
end