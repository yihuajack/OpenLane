# Copyright 2020-2022 Efabless Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
ARG RUN_BASE_IMAGE=
ARG BUILD_BASE_IMAGE=
ARG FAULT_REPO=
ARG FAULT_COMMIT=

FROM ghcr.io/aucohl/fault:${FAULT_COMMIT} AS build

# ---
FROM ${RUN_BASE_IMAGE} AS runnable
ENV PATH /build/bin:$PATH

ENV LD_LIBRARY_PATH=/build/lib\
    FAULT_IVL_BASE=/build/lib/ivl\
    FAULT_IVERILOG=/build/bin/iverilog\
    FAULT_VVP=/build/bin/vvp

RUN mkdir -p /build/version/
COPY --from=build /build /build
## Collisions with OpenLane Utilities
RUN rm -rf $(find /build/lib | grep python); rm -f /build/bin/python3
RUN rm -rf $(find /build/bin | grep yosys); rm -rf /build/share/yosys
RUN tar -czf /build.tar.gz /build
RUN date +"Build Timestamp: %Y-%m-%d_%H-%M-%S" > /build/version/fault.version
RUN echo ${FAULT_COMMIT} >> /build/version/fault.version