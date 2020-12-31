.PHONY: diff show
all: diff

# diff against locally deployed services
# TODO: parameterize
diff:
	tk diff environments/ghost-cms/prod

# TODO: parameterize
show:
	tk show --dangerous-allow-redirect environments/ghost-cms/prod > ./out/manifest.yaml
