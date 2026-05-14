#!/usr/bin/env bash

gh issue view $ISSUE_ID \
  --json 'assignees,author,body,closed,closedAt,closedByPullRequestsReferences,comments,createdAt,id,isPinned,labels,milestone,number,reactionGroups,state,stateReason,title,updatedAt,url' \
  --template \
'# {{ .title }}
> {{ .author.login }} create at {{ .createdAt }}

{{.body}}

{{ range .comments }}---
> {{ .author.login }} comment at {{ .createdAt }}

{{ .body }}
{{ end }}
'
