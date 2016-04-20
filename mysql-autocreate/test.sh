docker run \
	--rm \
	--label="mysql.db.name=foobar_test" \
	debian:jessie \
	bash -c "sleep 3"
