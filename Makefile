.PHONY: diff show
all: diff

# diff against locally deployed services
# TODO: parameterize
diff:
	tk diff environments/ghost-cms/dev

# TODO: parameterize
show:
	tk show --dangerous-allow-redirect environments/ghost-cms/dev > ./out/manifest.yaml
