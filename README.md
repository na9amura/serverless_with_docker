# serverless_with_docker

Environment for developping [serverless framework](https://serverless.com/) in Docker container.

NOTE: You need to setup manually as I've not automated serverless framework setup so far.

## How to use

### build
```sh
FROM tacamula/serverless_with_docker

# Remove if you set up credential in a other way
ENV AWS_ACCESS_KEY_ID={ id_key } \
  AWS_SECRET_ACCESS_KEY={ access_key }

# Change if you config to use other port
EXPOSE 3000 8000
```

```sh
docker build -t { tag name } .
```

### setup serverless framework
Go into container
```
docker run -p 3000:3000 -p 8000:8000 -v $PWD:/var/tasks -it { tag name } /bin/bash
```

#### Initialize
```
serverless create --template aws-nodejs --path { temp dir name }
shopt -s dotglob
cp { temp dir name }/* .
rm -r { temp dir name }
```

#### Add plugins
Edit serverless.yml
```yaml
plugins:
  - serverless-dynamodb-local
  - serverless-offline
```

#### Install dynamodb offline
```
serverless dynamodb install
```

### run
```
docker run -p 3000:3000 -p 8000:8000 -v $PWD:/var/tasks -it { tag name }
```

