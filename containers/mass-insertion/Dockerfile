FROM ubuntu:18.04
# See https://redis.io/topics/mass-insert

RUN set -ex; \
	apt-get update; \
	apt-get install -y --no-install-recommends redis; \
	rm -rf /var/lib/apt/lists/*; 

COPY data.txt /tmp
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
