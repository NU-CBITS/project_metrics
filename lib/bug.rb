require "json"

class Bug
  ONE_MINUTE_IN_MS = 60 * 1000
  SERVICE_GET = "curl -X GET -H \"X-TrackerToken: $PIVOTAL_TOKEN\""
  API_ROOT = "https://www.pivotaltracker.com/services/v5/projects/"

  def self.cycle_times_in_minutes(project:, owner:, period:)
    stories = `#{ SERVICE_GET } "#{ API_ROOT }#{ project }/search?query=type%3Abug%20owner%3A%22#{ owner }%22%20accepted_since%3A-#{ period }%20includedone:true&fields=stories(stories(id))"`
    ids = JSON.parse(stories)["stories"]["stories"].map { |s| s["id"] }

    story_analytics = `#{ SERVICE_GET } "#{ API_ROOT }#{ project }/stories/bulk?ids=#{ ids.join(',') }&fields=id,cycle_time_details(total_cycle_time)"`

    JSON.parse(story_analytics).map { |a| a["cycle_time_details"]["total_cycle_time"] / ONE_MINUTE_IN_MS }
  end

  def self.upcoming_ids(project:, owner:)
    stories = `#{ SERVICE_GET } "#{ API_ROOT }#{ project }/search?query=type%3Abug%20owner%3A%22#{ owner }%22%20state%3Aunstarted"`

    JSON.parse(stories)["stories"]["stories"].map { |s| s["id"] }
  end
end
