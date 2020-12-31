{
  _config+:: {
  cfdBlog: {
    ghost: {
       port: 2368,
       name: "ghost-cms",
       mountPath: "/var/lib/ghost/content",
       volumeSize: "1Gi",
       claimName: "blog-content",
    },
   },
  },
  _images+:: {
    cfdBlog: {
      ghost: "ghost:3.40-alpine"
    }
  }
}
