# TATask 
A simple task management system

# Table Schema

table tasks

column | type
--|--
title | string
content | text
state | integer
priority | integer
end_time | date
user_id | integer

table task_tags

column | type
---|---
task_id | integer
tag_id | integer

table tag

column | type
---|---
name | string

table user

column | type
---|---
email | string
name | string
password | string

