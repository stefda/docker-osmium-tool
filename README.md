# Osmium Tool on Docker

Read the [tool manual](http://osmcode.org/osmium-tool/) for detailed usage information.

## Example usage

Extract Greece from the planet download:

```bash
docker run -it -w /wkd -v $(pwd):/wkd vsverchkov/osmium-tool osmium extract --bbox=17.682871,33.679590,30.404538,42.269466 -o greece.osm.pbf planet-latest.osm.pbf
```

Filter all buildings, highways and beaches from the extract:

```bash
docker run -w /wkd -v $(pwd):/wkd osmium-tool osmium tags-filter -o greece-filtered.osm.pbf greece.osm.pbf building highway natural=beach
```
