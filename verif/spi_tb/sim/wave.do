onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group APB /hdl_top/DUT/PCLK
add wave -noupdate -expand -group APB /hdl_top/DUT/PRESETN
add wave -noupdate -expand -group APB /hdl_top/DUT/PADDR
add wave -noupdate -expand -group APB /hdl_top/DUT/PWDATA
add wave -noupdate -expand -group APB /hdl_top/DUT/PRDATA
add wave -noupdate -expand -group APB /hdl_top/DUT/PWRITE
add wave -noupdate -expand -group APB /hdl_top/DUT/PSEL
add wave -noupdate -expand -group APB /hdl_top/DUT/PENABLE
add wave -noupdate -expand -group APB /hdl_top/DUT/PREADY
add wave -noupdate -expand -group APB /hdl_top/DUT/PSLVERR
add wave -noupdate -expand -group SPI /hdl_top/DUT/ss_pad_o
add wave -noupdate -expand -group SPI /hdl_top/DUT/sclk_pad_o
add wave -noupdate -expand -group SPI /hdl_top/DUT/mosi_pad_o
add wave -noupdate -expand -group SPI /hdl_top/DUT/miso_pad_i
add wave -noupdate /hdl_top/DUT/IRQ
add wave -noupdate -expand -group Internal /hdl_top/DUT/divider
add wave -noupdate -expand -group Internal /hdl_top/DUT/ctrl
add wave -noupdate -expand -group Internal /hdl_top/DUT/ss
add wave -noupdate -expand -group Internal /hdl_top/DUT/wb_dat
add wave -noupdate -expand -group Internal /hdl_top/DUT/rx
add wave -noupdate -expand -group Internal /hdl_top/DUT/rx_negedge
add wave -noupdate -expand -group Internal /hdl_top/DUT/tx_negedge
add wave -noupdate -expand -group Internal /hdl_top/DUT/char_len
add wave -noupdate -expand -group Internal /hdl_top/DUT/go
add wave -noupdate -expand -group Internal /hdl_top/DUT/lsb
add wave -noupdate -expand -group Internal /hdl_top/DUT/ie
add wave -noupdate -expand -group Internal /hdl_top/DUT/ass
add wave -noupdate -expand -group Internal /hdl_top/DUT/spi_divider_sel
add wave -noupdate -expand -group Internal /hdl_top/DUT/spi_ctrl_sel
add wave -noupdate -expand -group Internal /hdl_top/DUT/spi_tx_sel
add wave -noupdate -expand -group Internal /hdl_top/DUT/spi_ss_sel
add wave -noupdate -expand -group Internal /hdl_top/DUT/tip
add wave -noupdate -expand -group Internal /hdl_top/DUT/pos_edge
add wave -noupdate -expand -group Internal /hdl_top/DUT/neg_edge
add wave -noupdate -expand -group Internal /hdl_top/DUT/last_bit
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {75170000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {74999160 ps} {80164760 ps}
