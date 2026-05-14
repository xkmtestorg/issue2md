#!/usr/bin/env bash

gh issue view https://github.com/xkmtestorg/issue2md/issues/1 \
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
