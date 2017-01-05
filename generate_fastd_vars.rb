require 'json'
require 'resolv'

def run_fastd_generate_key
  `fastd --generate-key > temp.key`
  data = File.open('temp.key').readlines
  File.unlink('temp.key')
  data
end

def generate_keys
  data = run_fastd_generate_key
  data.collect do |key|
    type, keystring = key.split(': ')
    { type.downcase.to_sym => keystring.chomp }
  end
end

def skip_comments_and_group_lines(line)
  line =~ /^#/ || line =~ /\[/ || line.strip.empty?
end

def main(filename)
  ip = 1
  vars = {}
  File.open(filename).each do |line|
    next if skip_comments_and_group_lines line

    host = line.split[0]

    vars[host] = generate_keys.inject(:merge)
    vars[host][:ip] = "10.61.0.#{ip}"
    vars[host][:remote] = Resolv.getaddress host

    ip += 1
  end

  File.write('fastd.json', { fastd: vars }.to_json)
end

main ARGV[0]
