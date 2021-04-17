# users table

| column             | type     | options                  |
| ------------------ | -------- | ------------------------ |
| name               | string   | null: false              |
| introduction       | text     |                          |
| email              | string   | null: false,unique: true |
| encrypted_password | string   | null: false              |

## Associations
--has_many: delis

# categories table

| column             | type     | options                  |
| ------------------ | -------- | ------------------------ |
| name               | string   | null: false              |

## Associations

--has_many: delis

# delis table

| column         | type       | options                       |
| -------------- | ---------- | ----------------------------- |
| name           | string     | null: false                   |
| text           | text       | null: false                   |
| supermarket_id | integer    | null: false                   |
| user_id        | references | null: false,foreign_key: true |
| categories_id  | references | null: false,foreign_key: true | 


## Associations
--belongs_to: user
--belongs_to: category
--has_many: deli_tag_relations
--has_many: tags, through: deli_tag_relations

# tags table
| column   | type       | options                       |
| -------- | ---------- | ----------------------------- |
| name     | string     | null: false, uniqueness: true |

## Associations
--has_many: deli_tags_relations
--has_many: delis, through: deli_tag_relations

# deli_tag_relations table
| column  | type       | options                       |
| ------- | ---------- | ----------------------------- |
| deli_id | references | null: false,foreign_key: true |
| tag_id  | references | null: false,foreign_key: true |

## Associations
--belongs_to: deli
--belongs_to: tag

