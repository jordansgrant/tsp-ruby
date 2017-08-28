require 'optparse'
require 'pp'

require_relative "./version.rb"

module TSP

  class TspParser

    # Returns a hash of the arguments
    def self.parse(args)
      # setting defaults
      options = { 
        algo:       :genetic, 
        seed_algo:  :nearest_neighbor, 
        crossover:  20,
        rate:       0.015
      }

      opt_parser = OptionParser.new do |opts|
        opts.banner = "Usage: ruby #{$0} [options]"

        opts.separator ""
        opts.separator "Mandatory options:"

        opts.on("-f FILE", "--infile=FILE", "Specify the Input File") do |file|
          abort("#{file} could not be found") unless File.exists? file
          options[:infile] = file
        end

        opts.on("-p SIZE", "--population-size=SIZE", "Set the population size") do |size|
          options[:pop_size] = size.to_i
          abort "#{size}: invalid population size" if size.to_i.zero?
        end

        opts.on("-g NUMBER", "--generations=NUMBER", "Set the number of generations") do |num|
          options[:generations] = num.to_i
          abort "#{num}: invalid number of generations" if num.to_i.zero?
        end


        opts.separator ""
        opts.separator "Special Options:"

        opts.on("--algo=[TYPE]", [:genetic, :two_opt],
                "Select algorithm type (genetic (default), two_opt)") do |t|
          options[:algo] = t
        end

        opts.on("--seed-algo=[TYPE]", [:nearest_neighbor, :random_tour],
                "Select seed algorithm type (nearest_neighbor (default), random_tour)") do |t|
          options[:seed_algo] = t
        end


        opts.on("-c SIZE", "--crossover=SIZE", 
                "Set the size of crossover sample population (default: 20)") do |size|
          options[:crossover] = num.to_i if num.to_i.to_s.equal? size and not num.to_i.zero?
        end
        
        opts.on("-r FLOAT", "--mutation-rate=FLOAT", 
                "Set the mutation rate ( range: 0.0-0.25, default: 0.015)") do |rate|
          options[:rate] = rate.to_f if rate.to_f.to_s.equal? rate and rate.to_f.between?(0.0..0.25)
        end


        opts.separator ""
        opts.separator "Informational options:"

        # No argument, shows at tail.  This will print an options summary.
        # Try it and see!
        opts.on_tail("-h", "--help", "Display Help Message") do
          puts opts
          exit
        end

        # Another typical switch to print the version.
        opts.on_tail("--version", "Show version") do
          puts "Traveling Salesman Problem in Ruby\n\tauthor: Jordan Grant\n\tversion: #{TSP.Version}"
          exit
        end
      end

      opt_parser.parse!(args)
      options
    end  # parse()

  end  # class TspParser
end    # module TSP

#options = TSP::TspParser.parse(ARGV)
#pp options
#pp ARGV
