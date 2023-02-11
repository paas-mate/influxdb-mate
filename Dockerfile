FROM shoothzj/compile:rust AS build
COPY . /opt/sh/compile
WORKDIR /opt/sh/compile
RUN /root/.cargo/bin/cargo build


FROM ttbb/influxdb:nake

COPY docker-build /opt/influxdb/mate

COPY --from=build /opt/sh/compile/target/debug/influxdb-mate-rust /opt/influxdb/mate/influxdb-mate

WORKDIR /opt/influxdb

CMD ["/usr/bin/dumb-init", "bash", "-vx", "/opt/influxdb/mate/scripts/start.sh"]
