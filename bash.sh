#!/usr/bin/env bash
gh issue view 1 --json \
number,title,body,author,assignees,labels,milestone,state,stateReason,createdAt,updatedAt,closed,closedAt,url,comments \
--jq '
  def list_or_none(stream):
    if (stream | length) > 0 then stream else ["- None"] end;

  [
    ("# Issue #" + (.number|tostring) + ": " + .title),
    "",
    ("- URL: " + .url),
    ("- State: " + .state + (if .stateReason then " (" + .stateReason + ")" else "" end)),
    ("- Author: " + .author.login),
    ("- Created: " + .createdAt),
    ("- Updated: " + .updatedAt)
  ]
  + (if .closed then [("- Closed: " + .closedAt)] else [] end)
  + list_or_none(.assignees | map("- Assignee: " + .login + (if .name then " (" + .name + ")" else "" end)))
  + list_or_none(.labels | map("- Label: " + .name))
  + [("- Milestone: " + (if .milestone then .milestone.title else "None" end))]
  + [
      "",
      (if .body then .body else "_No description_" end)
    ]
  + (if (.comments | length) > 0 then
      (.comments | map([
        "",
        ("# Author: " + .author.login),
        "",
        ("Created: " + .createdAt),
        "",
        (if .body then .body else "_No comment body_" end)
      ] | join("\n")))
    else
      []
    end)
  | join("\n")
'

