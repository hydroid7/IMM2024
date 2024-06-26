#import "@preview/polylux:0.3.1": *
#import "./uni-passau.typ": *

#import "@preview/fletcher:0.4.2" as fletcher
#import fletcher: node, edge
#import fletcher.shapes: house, hexagon

#let blob(pos, label, tint: white, ..args) = node(
  pos, align(center, label),
  width: 25mm,
  fill: tint.lighten(60%),
  stroke: 1pt + tint.darken(20%),
  corner-radius: 5pt,
  ..args,
)

#show: uni-passau-theme.with(
  footer: [Lóránt Meszlényi #sym.bar.v IMM 2024 #sym.bar.v Infineon PV Optimizer],
)

#set text(font: "Fira Sans", size: 20pt)
#show math.equation: set text(font: "Fira Math")
#set strong(delta: 100)
#set par(justify: true)


#let presentation_termin = datetime(
  year: 2024,
  month: 06,
  day: 27,
)

#title-slide(
  author: [Lóránt Meszlényi],
  title: "Industry Meets Makers 2024",
  subtitle: "Infineon PV Optimizer Implementation",
  date: datetime.today().display("[month repr:long] [day], [year]"),
  extra: [
    #align(bottom,
      pad(
        top: 2em,
        grid(
          columns: 2,
          gutter: 1em,
          strong("Betreuer "), "Ewald Wasmeier",
          strong("Vortragtermin "), presentation_termin.display("[month repr:long] [day], [year]"),
          strong("Studiengang"), "Master Informatik",
        )
      )
    )
  ]
)

// #slide(title: "Table of contents")[
//   #outline
// ]

#new-section-slide("Theory")


#slide(title: [#utils.current-section: Buck-Boost-Converter])[
  #figure(
    image("./figures/converter_diagram.drawio.svg"),
    caption: [Buck boost converter schematic design.]
  )
]

#slide(title: [#utils.current-section: Buck-Boost-Converter])[
  #figure(
    image("./figures/duty_cycle_mode.drawio.svg"),
    caption: [Buck-boost converter operation modes.]
  )
]

#slide(title: [#utils.current-section: Buck-Boost-Converter])[
  #figure(
    image("./figures/duty_cycle_op_modes.svg"),
    caption: [Buck-boost converter operation modes over the entire voltage range.]
  )
]

#new-section-slide("Implementation")

#slide(title: [#utils.current-section: DAVE IDE])[
  #figure(
    image("./figures/dave_ide_screenshot.png"),
    caption: [Instantiated hardware peripherals.]
  )
]

#new-section-slide("Results & Challenges")

#slide(title: [#utils.current-section: Results])[
#set list(marker: "✓")
- All peripherials are configured
- PWM Peripherial works
- ADC works most of the time
- Started to implement "Perturb and Optimize MPPT"
]


#slide(title: [#utils.current-section: TODOs])[
#set list(marker: "✗")
- Test and verify synchronous PWM
- UART
- ADC filtering
- Efficiency measurements
]

#slide(title: [#utils.current-section: Challenges])[
#set list(marker: "-")
- Debugger not working
- Semihosting not working
#sym.arrow.r.loop debugging only over PWM
#v(10mm)

- No test points on PCB
#sym.arrow.r.loop Hard to measure anything
]

// #slide(title: [#utils.current-section: Bypass technology])[
//   #grid(columns: (50%, 50%), [
//     - Virtual switch using Linux (TUN or TAP interfaces)
//     - Hardware bypass (on MII level)
//     - AF_XDP based bypass
//     - DPDK based bypass
//   ], [
//     #image("./figures/NetworkStack.drawio.svg")
//   ]
//   )
// ]

// #slide(title: [#utils.current-section: Software Architecture])[
//   #figure(
//     image("./figures/software_architecture.drawio.svg"),
//     caption: [The implemented software architecture.]
//   )
// ]

// #slide(title: [#utils.current-section: AF_XDP])[
//   #figure(
//     image("./figures/AF_XDP.drawio.svg"),
//     caption: [Unified shared memory segment UMEM.]
//   )
// ]

// #slide(title: [#utils.current-section: AF_XDP])[
//   #figure(
//     image("./figures/AF_XDP_2.drawio.svg"),
//     caption: [Communication in AF_XDP between userspace and kernel space with rings.]
//   )
// ]

// #slide(title: [#utils.current-section: AF_XDP])[
//   #figure(
//     image("./figures/global_scheduler_threads.drawio.svg"),
//     caption: [Implemented scheduler architecture.]
//   )
// ]

// #slide(title: [#utils.current-section: Packet Priorization])[
  
//   My implementation based on IEEE 802.1Qcr (#alert[A]synchronous #alert[T]raffic #alert[S]haper):

//   #figure(
//     image("./figures/ats_scheduler_end_station.drawio.svg"),
//     caption: [Traffic shaper using ATS.]
//   )
// ]


// #slide(title: [#utils.current-section: Packet Priorization])[
//   #import "@preview/algo:0.3.3": algo, i, d, comment, code
//   #figure(
//     algo(
//       title: "Process packages",
//       parameters: ("n", "queue", "link_cap")
//     )[
//       in_buf := sort(queue.take(n)) #comment[take and sort by urgentness]\
//       index := 0\
//       out_buf := [0; n] \
//       while $text("in_buf") eq.not emptyset or text("out_buf.size()") < text("link_cap")$:#i\
//         index++\
//         out_buf.add(in_buf.pop())#d\
//       end\
//       recycle(in_buf[index..end]) #comment[give back not transmitted]\
//       return out_buf\
//     ], 
//     caption: [Pseudocode of the scheduler algorithm]
//   )
// ]

// #new-section-slide("Results")

// #slide(title: [#utils.current-section: Measurements])[
//   Measured variables:
//   - Latency
//   - Relative packet order
//   Parameters:
//   - Packet frequency
//   - Packet size
//   Fixed variables:
//   - Number of participants (readers and writers)
//   - Network topology
//   - Additional network noise
// ]

// #slide(title: [#utils.current-section: Latency])[
//   #grid(
//     columns: (50%, 50%), column-gutter: 1em, [
//       #figure(
//         image("./figures/global_scheduler_threads.drawio.svg"),
//         caption: [Implemented scheduler architecture.],
//         numbering: it => "11"
//       )
//     ], [
// #figure(
//   kind: table,
//   table(
//     columns: (auto, auto, auto),
//     inset: 6pt,
//     // auto-vlines: false,
//     align: horizon,
//     [*Number*], [*Receive path*], [*Send path*],
//     [1], [XDP timestamp], [PosixMQ timestamp],
//     [2], table.cell(colspan:2, [Push to channel]),
//     [3], table.cell(colspan:2, [Channel receive and sort by priority]),
//     [4], [Send over PosixMQ], [Send over XDP]
//   ),
//   caption: [Recorded timestamps during execution.]
// ) <table:experiment-timestamps>
//     ]
//   )
// ]

// #slide(title: [#utils.current-section: Smallest Latency])[
//   #grid(columns: (50%, 50%), column-gutter: 1em, [
//     #figure(
//       image("analysis/gs_receive_100Hz_64B.svg"),
//       caption: [Best result ingress: 64 byte payload with 100 Hz packet frequency]
//     )
//   ], [
//     #figure(
//       image("analysis/gs_send_100Hz_64B.svg"),
//       caption: [Best result egress: 64 byte payload with 100 Hz packet frequency]
//     )
//   ])
// ]

// #slide(title: [#utils.current-section: Biggest Latency])[
//   #grid(columns: (50%, 50%), column-gutter: 1em, [
//     #figure(
//       image("analysis/gs_receive_100kHz_1024B.svg"),
//       caption: [Worst result ingress: 1024 byte payload with 100 kHz packet frequency]
//     )
//   ], [
//     #figure(
//       image("analysis/gs_send_100kHz_1024B.svg"),
//       caption: [Worst result egress: 1024 byte payload with 100 kHz packet frequency]
//     )
//   ])
// ]


// #slide(title: [#utils.current-section: Packet ordering egress])[
//   #figure(
//     image("analysis/gs_prio_send_100kHz_10Hz.svg"),
//     caption: [Topic A (100 kHz, class "best effort") and topic B (100 Hz, class "priority").],
//   ) <fig:gs_qos_outgoing_0>
// ]


// #slide(title: [#utils.current-section: Packet ordering egress])[
//   #grid(
//     columns: (50%, 50%),
//     column-gutter: 1em,
//     [
//       Best effort: 100 Hz, Priority: 100 Hz
//       #image("analysis/qos_send_4.svg")
//     ], [
//       Best effort: 1 kHz, Priority: 100 Hz
//       #image("analysis/qos_send_5.svg")
//     ]
//   )
// ]

// #slide(title: [#utils.current-section: Packet ordering ingress])[
//     #figure(
//     image("analysis/qos_receive_example.svg"),
//     caption: [Topic A (100 kHz, class "best effort") and topic B (100 Hz, class "priority").],
//   ) <fig:gs_qos_outgoing_0>
  
// ]

// #slide(title: [#utils.current-section: Packet ordering ingress])[
//   #grid(
//     columns: (50%, 50%),
//     column-gutter: 1em,
//     [
//       Best effort: 100 Hz, Priority: 100 Hz
//       #image("analysis/qos_receive_1.svg")
//     ], [
//       Best effort: 1 kHz, Priority: 100 Hz
//       #image("analysis/qos_receive_2.svg")
//     ]
//   )
// ]

// #new-section-slide("Conclusion")


// #slide(title: [#utils.current-section: Good])[
//   - Packet reordering achieved
//   - Implementation of a DDS Middleware
//   - Latency is lower than the kernel
//   - Flexible Framework
//   - Secure software architecture (central communication component)
//   - "Zero copy" is not relevant in context of DDS
// ]

// #slide(title: [#utils.current-section: Lesson learned])[
//   - Networking is a higly complex subsystem
//     - Hardware
//     - Kernel
//     - Queues
//     - Offloading
//     - Shared memory
//     - #sym.dots
//   - Polling vs Notification (Latency vs Throughput)
//   - Time / LoC

// ]

// #slide(title: "Bibliography")[
//   #bibliography("./thesis.bib", title: none)
// ]

// #slide(title: "Appendix I: Rust for safety-critical systems")[
//   #grid(columns: (60%, 40%), column-gutter: 1em, [
//     - Rust compiler guarantees memory ownership
//     - Statically typed language
//     - Certified compiler available for:
//       - ISO 26262 (ASIL D)
//       - IEC 61508 (SIL 4)

//   ], [
//     #figure(image("./figures/tuv.png"))
//   ])
// ]

// #show link: it => [#alert[#sym.arrow.r.loop #underline(it)]]

// #slide(title: "Appendix I: Rust for safety-critical systems")[
//   - But: there is no "Rust Specification by ISO #sym.dots"
//   - "Standard" & semantics derived from extensive test suite (#link("https://public-docs.ferrocene.dev/main/specification/index.html")[Rust Specification by Ferrocene GmbH])
//   - Current version v1.68
// ]

// #slide(title: "Appendix II: XDP and eBPF")[
//     #grid(columns: (50%, 50%), column-gutter: 1em, [
//       - First introduced: AF_PACKET v4
//       - Later: AF_XDP
//       - Accelerated raw packet access
//       - eXpress Data Path
//         - Berkeley Packet Filter #sym.arrow BPF #sym.arrow extended BPF
//   ], [
//       #figure(
//         image("./figures/XDP_AF_XDP.drawio.svg")
//       )
//   ])
// ]

// #slide(title: "Appendix II: XDP and eBPF")[
//   #grid(columns: (50%, 50%), column-gutter: 1em, [
//     - First introduced: AF_PACKET v4
//     - Later: AF_XDP
//     - eXpress Data Path
//     - Berkeley Packet Filter #sym.arrow BPF #sym.arrow extended BPF
//   ], [
//       #figure(
//         image("./figures/XDP_AF_XDP.drawio.svg")
//       )
//   ])
// ]

