# Setting Up and Configuring Conky

## Introduction

Conky is a lightweight system monitor that can display various system information on your desktop. This documentation will guide you through the process of installing Conky, configuring the provided `.conkyrc` file, and displaying system information on your desktop.

## Step 1: Install Conky

1. Open a terminal window.

2. Run the following command to install Conky:

   ```
   sudo apt-get install conky lm-sensors hddtemp
   sudo sensors-detect
   sudo hddtemp /dev/sda1
   sudo smartctl -A /dev/nvme0n1 | grep Temperature:
   ```

3. conkyrc file - 
```
conky.config = {
    alignment = 'top_right',
    background = false,
    border_width = 3,
    cpu_avg_samples = 2,
    default_color = 'white',
    default_outline_color = 'white',
    default_shade_color = 'white',
    double_buffer = true,
    draw_borders = false,
    draw_graph_borders = true,
    draw_outline = false,
    draw_shades = false,
    extra_newline = false,
    font = 'DejaVu Sans Mono:size=12',
    gap_x = 50,
    gap_y = 90,
    minimum_height = 7,
    minimum_width = 6,
    net_avg_samples = 2,
    no_buffers = true,
    out_to_console = false,
    out_to_ncurses = false,
    out_to_stderr = false,
    out_to_x = true,
    own_window = true,
    own_window_class = 'Conky',
    own_window_type = 'desktop',
    show_graph_range = false,
    show_graph_scale = false,
    stippled_borders = 0,
    update_interval = 1.0,
    uppercase = false,
    use_spacer = 'none',
    use_xft = true,
}

conky.text = [[
${color grey}${scroll 32 $sysname $nodename $kernel $machine}
$hr
${color grey}${alignc}Computing systems

${color grey}Uptime: $color$uptime
${color grey}Frequency : $color$freq_g GHz
${color grey}CPU Usage:$color $cpu%
${color grey}CPU Temp:${color} ${execi 10 sensors | grep 'Core 0' | awk '{print $3}'}
$hr
${color grey}${alignc}File systems

${color grey}SSD Temp: ${color}${execi 10 sudo smartctl -A /dev/nvme0n1 | grep Temperature: | awk '{print $2}'}°C
${color grey}HDD Usage: $color${fs_used /home} / ${fs_size /home}
${color grey}HDD Temp: ${color}${execi 10 sudo hddtemp /dev/sda1 | awk '{print $4}'}
${color grey}RAM Usage: $color$mem / $memmax 
${color grey}Swap Usage: $color$swap / $swapmax
$hr
$hr
${color grey}${alignc}Networks

${color grey}IP Address: $color${addr wlo1}
${color grey}Up:$color ${upspeedf wlo1}kbps - ${color grey}Down:$color ${downspeedf wlo1}kbps
$hr
]]
```
