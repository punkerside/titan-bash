build_image:
	@export GIT_HOME=${GIT_HOME} && ${GIT_HOME}/scripts/build.sh function_build_image

build_code:
	@export GIT_HOME=${GIT_HOME} && ${GIT_HOME}/scripts/build.sh function_build_code

build_packer:
	@export GIT_HOME=${GIT_HOME} && ${GIT_HOME}/scripts/build.sh function_build_packer