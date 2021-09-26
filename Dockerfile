############################
# STEP 1 build executable binary
############################
FROM golang:alpine AS builder
# Install git.
# Git is required for fetching the dependencies.
RUN apk update && apk add --no-cache git
WORKDIR $GOPATH/src/mirror/
ADD main.go .
ADD go.mod .
ADD go.sum .
# Fetch dependencies.
# Using go get.
RUN go get -d -v
# Build the binary.
ENV CGO_ENABLED=0
RUN go build -o /go/bin/mirror
############################
# STEP 2 build a small image
############################
FROM scratch
# Copy our static executable.
COPY --from=builder /go/bin/mirror /mirror
# Run the binary.
#ENTRYPOINT ["ls", "-lah", "/mirror"]
ENTRYPOINT ["/mirror"]