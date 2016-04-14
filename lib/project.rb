require_relative "bug"

class Project
  PERIOD = {
    past_six_months: "26weeks"
  }
  SIMULATION_COUNT = 100
  LEFT_COLUMN = 4
  MINUTES_PER_HOUR = 60

  def initialize(project_id:, owner:)
    @project_id = project_id
    @owner = owner
  end

  def predicted_bug_cycle_time_in_minutes
    sorted_samples = (0..SIMULATION_COUNT).map do |c|
      bug_cycle_times_in_minutes.sample
    end.sort

    sorted_samples.map.with_index do |sample, i|
      "#{ (i + 1).to_s.rjust(LEFT_COLUMN)} #{ pretty_time sample }"
    end
  end

  private

  def bug_cycle_times_in_minutes
    @bug_cycle_times_in_minutes ||=
      Bug.cycle_times_in_minutes(project: @project_id,
                                 owner: @owner,
                                 period: PERIOD[:past_six_months])
  end

  def pretty_time(minutes)
    if minutes < 60
      "#{ minutes }m"
    else
      "#{ minutes / MINUTES_PER_HOUR }h"
    end
  end
end

PROJECTS = {
  conemo: 1020072
}
OWNERS = {
  ecf: "ECF"
}

#puts Bug.cycle_times_in_minutes(project: PROJECTS[:conemo], owner: OWNERS[:ecf], period: PERIOD[:past_six_months])
#puts Bug.upcoming_ids(project: PROJECTS[:conemo], owner: OWNERS[:ecf])
project = Project.new(project_id: PROJECTS[:conemo], owner: OWNERS[:ecf])
puts project.predicted_bug_cycle_time_in_minutes
