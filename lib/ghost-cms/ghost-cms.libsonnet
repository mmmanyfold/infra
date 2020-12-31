(import "ksonnet-util/kausal.libsonnet") +
{
  local c = $._config.mmmBlog,
  local deployment = $.apps.v1.deployment,
  local container = $.core.v1.container,
  local port = $.core.v1.containerPort,
  local service = $.core.v1.service,
  local volume = $.core.v1.volume,
  local volumeMount = $.core.v1.volumeMount,

  local pvc  = {
    apiVersion: "v1",
    kind: "PersistentVolumeClaim",
    metadata: {
      name: c.ghost.claimName,
      labels: {
        app: c.ghost.name,
      },
    },
    spec: {
      accessModes: [
        "ReadWriteOnce",
      ],
      resources: {
        requests: {
          storage: c.ghost.volumeSize,
        },
      }
    },
  },

  mmmBlog: {
    deployment: deployment.new(
      name=c.ghost.name,
      replicas=1,
      containers=[
        container.new(c.ghost.name, $._images.mmmBlog.ghost) +
        container.withPorts([port.new("container-port", c.ghost.port)]) +
        container.withVolumeMounts([
          { mountPath: c.ghost.mountPath, name: c.ghost.name},
        ]) +
        container.withEnvMap({url: "https://blog.kimchitaco.club"}),
      ],
    ) +
    deployment.mixin.spec.template.spec.withVolumes([{
      name: c.ghost.name,
      persistentVolumeClaim: {
        claimName: c.ghost.claimName,
       }
      },
    ]),
    service: $.util.serviceFor(self.deployment) {
      spec+: { type: "LoadBalancer" },
    },
    volumes: pvc,
  }
}
