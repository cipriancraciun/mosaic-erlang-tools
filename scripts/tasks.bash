#!/dev/null

if ! test "${#}" -eq 0 ; then
	echo "[ee] invalid arguments; aborting!" >&2
	exit 1
fi

cat <<EOS

${_package_name}@requisites : pallur-packages@erlang-${_otp_version} pallur-packages@vbs pallur-packages@ninja pallur-bootstrap

# FIXME: Move this to the requisites of mosaic-node!
${_package_name}@requisites : pallur-packages@jansson

${_package_name}@prepare : ${_package_name}@requisites
	!exec ${_scripts}/prepare

${_package_name}@package : ${_package_name}@compile
	!exec ${_scripts}/package

${_package_name}@compile : ${_package_name}@prepare
	!exec ${_scripts}/compile

${_package_name}@deploy : ${_package_name}@package
	!exec ${_scripts}/deploy

pallur-distribution@requisites : ${_package_name}@requisites
pallur-distribution@prepare : ${_package_name}@prepare
pallur-distribution@compile : ${_package_name}@compile
pallur-distribution@package : ${_package_name}@package
pallur-distribution@deploy : ${_package_name}@deploy

EOS

exit 0