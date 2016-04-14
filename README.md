# Pivotal project metrics

## Get CSV formatted iteration cycle time details

```
curl -X GET -H "X-TrackerToken: $PIVOTAL_TOKEN" "https://www.pivotaltracker.com/services/v5/projects/1020072/iterations/103/analytics/cycle_time_details.csv"
```

## How do I get the cycle times for all bugs for a developer on a project in a given time span?

First: get all accepted bugs for a developer on a project in a given time span.

```
curl -X GET -H "X-TrackerToken: $PIVOTAL_TOKEN" "https://www.pivotaltracker.com/services/v5/projects/1020072/search?query=type%3Abug%20owner%3A%22ECF%22%20accepted_since%3A-26weeks%20includedone:true"
```

(Just return story ids)
```
&fields=stories(stories(id))
```

Second: get the cycle times for a set of stories.

```
curl -X GET -H "X-TrackerToken: $PIVOTAL_TOKEN" "https://www.pivotaltracker.com/services/v5/projects/1020072/stories/bulk?ids=117162203,116778863&fields=id,cycle_time_details(total_cycle_time)"
```

## How do I get upcoming bugs for a developer on a project?

```
curl -X GET -H "X-TrackerToken: $PIVOTAL_TOKEN" "https://www.pivotaltracker.com/services/v5/projects/1020072/search?query=type%3Abug%20owner%3A%22ECF%22%20state%3Aunstarted"
```
