FROM google/cloud-sdk:244.0.0-alpine

ENV CLOUDSDK_CORE_PROJECT="" \
	GOOGLE_APPLICATION_CREDENTIALS="/config/service-account.json" \
	BUCKET_NAME="" \
	BUCKET_PATH="" \
	DELETE="false"

VOLUME ["/mnt", "/config"]

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]