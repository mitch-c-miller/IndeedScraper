require 'rubygems'
require 'time'

class FileManager
  def file_output()
    Dir.chdir("./Results") do
      time = Time.new
      # out = File.open("indeed" << ARGV[0].dup << ARGV[1].dup << time.strftime("%Y-%m-%d") << ".txt", "w")
      out = File.open("indeed" << time.strftime("%Y-%m-%d") << ".txt", "w")
    end
  end

  def load_lists(list)
    Dir.chdir("./ParseLibrary") do
      if list == true
        special = Array.new
        File.readlines('special.txt').each do |line|
          special << line
        end
        puts special

      elsif list == false
        exclude = Array.new
        File.readlines('exclude.txt').each do |line|
          exclude << line
        end
        puts exclude
      
      else
        abort "Incorrect list variable"
      end
    # end of directory change
    end
  # end of function
  end
# end of class
# never thought I would miss curly braces for organization
end

out_check = FileManager.new
temp = "indeed"
out_check.file_output()
out_check.load_lists(true)
out_check.load_lists(false)