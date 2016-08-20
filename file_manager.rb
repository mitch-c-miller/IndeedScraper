require 'rubygems'
require 'time'

class FileManager
  def file_output(board, job, location)
    Dir.chdir("./Results") do
      time = Time.new
      out = File.open(board << job << location << time.strftime("%Y-%m-%d") << ".txt", "w")
      return out
    end
  end

  def load_lists(list)
    Dir.chdir("./ParseLibrary") do
      if list == true
        special = Array.new
        File.readlines('special.txt').each do |line|
          special << line
        end
        return special

      elsif list == false
        exclude = Array.new
        File.readlines('exclude.txt').each do |line|
          exclude << line
        end
        return exclude
      
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