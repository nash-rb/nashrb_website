# Nash.rb Website

## Dependencies
- `ruby 2.4.4`

## First Run

```sh
bin/setup
```

## After pulling in fresh changes
```sh
bin/update
```

## To run tests
```sh
rake # default rake task is the tests
```

## To generate the Entity Relationship Diagram
```sh
rake db:migrate
# or
bundle exec erd
```
This generated an `erd.pdf` file which is not checked in since it is so large.
