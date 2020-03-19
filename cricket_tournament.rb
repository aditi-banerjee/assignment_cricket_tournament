#open & read file
@input_file = File.open(ARGV[0])
readen = @input_file.read()

#Set input for process
@inputs = readen.split(/\n+/)
data = {}
@inputs.each do |input|
	latest_update = input.split(";")
	team_1 = latest_update[2] == "win" ? latest_update[0] : latest_update[1]
	team_2 = latest_update[2] == "win" ? latest_update[1] : latest_update[0]
	p team_1
	p team_2
	data.merge!(team_1 => {mp: 0, w: 0, d: 0, l: 0, p: 0}) if !data.key?(team_1)
	data.merge!(team_2 => {mp: 0, w: 0, d: 0, l: 0, p: 0}) if !data.key?(team_2)
		if (latest_update[2] == "win" || latest_update[2] == "loss")
			data[team_1][:mp] += 1
			data[team_1][:w] += 1
			data[team_1][:p] += 3
			data[team_2][:mp] += 1
			data[team_2][:l] += 1
		elsif (latest_update[2] == "draw")
			data[team_1][:mp] += 1
			data[team_1][:d] += 1
			data[team_1][:p] += 1
			data[team_2][:mp] += 1
			data[team_2][:d] += 1
			data[team_2][:p] += 1
		end
end
score = data.sort_by { |k, v| [-v[:p], k]}.to_h
p "=Result="
p score
