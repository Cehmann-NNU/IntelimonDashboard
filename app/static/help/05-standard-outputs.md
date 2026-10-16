# Standard outputs

## What this tab is for

Standard outputs shows the core structural metrics that IntELiMon calculates
for every scan that can be directly interpreted: tree statistics, vegetation
volume by height layer and canopy statistics. These metrics can be used by
managers without any predictive model building that requires training data
collection and analyses. This provides users with "out-of-the-box" utility
after the first monitoring season.

Use the tab to see how a metric changes over time, before and after a
treatment, and how much it varies among plots. Three graph cards show one of
three metric types: tree, volume and canopy metrics. A fourth card shows the
Points2Pano panorama of the scans. This allows a user to view the metrics in
the context of the scan and provides a QA/QC assessment of the scans. The
settings in the left panel apply to all three graphs.

These graphs use data from the scans downloaded on the **Selection Map** and
the treatment dates entered on **Set Treatments**.

## The screen at a glance

Move the mouse over a numbered marker, or press Tab to step through them, to
see what each part does.

<div class="help-shot"><img src="static/help/images/standard-outputs-overview.png" alt="The Standard outputs tab: plot settings and metric lists on the left, three metric graphs and the Points2Pano viewer on the right" width="800">
<span class="help-spot tip-right" tabindex="0" style="left:18.75%;top:7.8%">1<span class="help-tip"><b>Plot type.</b> How the graphs draw the data: time series, one line per plot, box and whisker, or bars.</span></span>
<span class="help-spot tip-right" tabindex="0" style="left:18.75%;top:15%">2<span class="help-tip"><b>Data type.</b> Values in the metric's own units, or percent change from each plot's first scan.</span></span>
<span class="help-spot tip-right" tabindex="0" style="left:20%;top:22%">3<span class="help-tip"><b>Treatment date lines.</b> Shows or hides the red lines at the treatment dates.</span></span>
<span class="help-spot tip-right" tabindex="0" style="left:20%;top:29.1%">4<span class="help-tip"><b>Error bars.</b> SD (spread among plots), SE (precision of the mean) or Off.</span></span>
<span class="help-spot tip-right" tabindex="0" style="left:20%;top:35.5%">5<span class="help-tip"><b>Tree statistics.</b> The metric for the upper left graph.</span></span>
<span class="help-spot tip-right" tabindex="0" style="left:20%;top:42.7%">6<span class="help-tip"><b>Volume statistics.</b> The metric for the upper right graph.</span></span>
<span class="help-spot tip-right" tabindex="0" style="left:20%;top:54%">7<span class="help-tip"><b>Canopy statistics.</b> The metric for the lower left graph.</span></span>
<span class="help-spot tip-right" tabindex="0" style="left:31.9%;top:6.4%">8<span class="help-tip"><b>Graph title.</b> The metric shown, with its code in brackets.</span></span>
<span class="help-spot tip-right" tabindex="0" style="left:34%;top:29%">9<span class="help-tip"><b>Error bar.</b> ±1 SD or SE around the mean of the time step.</span></span>
<span class="help-spot tip-right" tabindex="0" style="left:40.6%;top:19.6%">10<span class="help-tip"><b>Treatment line.</b> A treatment date from the Set Treatments tab.</span></span>
<span class="help-spot tip-right" tabindex="0" style="left:46.5%;top:38.1%">11<span class="help-tip"><b>Time step mean.</b> The average of the scans in one time step.</span></span>
<span class="help-spot tip-left" tabindex="0" style="left:52.5%;top:13%">12<span class="help-tip"><b>Error bar label.</b> Says what the error bars show.</span></span>
<span class="help-spot tip-left" tabindex="0" style="left:96.5%;top:52.2%">13<span class="help-tip"><b>Scan label.</b> The site, plot, date and scanner of the panorama. The ◀ and ▶ buttons beside it step through the selected scans; in a narrow window they can be hidden, so expand the card.</span></span>
<span class="help-spot tip-left tip-up" tabindex="0" style="left:80%;top:74%">14<span class="help-tip"><b>Points2Pano viewer.</b> A 360° panorama made from the scan. Use the viewer's own controls to look around.</span></span>
</div>

1. **Plot type**: how the graphs draw the data.
2. **Data type**: values or percent change.
3. **Treatment date lines**: show or hide the treatment lines.
4. **Error bars**: SD, SE or none.
5. **Tree statistics**: metric for the upper left graph.
6. **Volume statistics**: metric for the upper right graph.
7. **Canopy statistics**: metric for the lower left graph.
8. **Graph title**: the metric shown.
9. **Error bar** around a time step's mean.
10. **Treatment line** at a treatment date.
11. **Time step mean**.
12. **Error bar label**.
13. **Scan label** of the panorama, with ◀ and ▶ to change scans.
14. **Points2Pano viewer**.

## The metrics

| List | Metric | What it describes |
|---|---|---|
| Tree statistics | Basal area | Cross-sectional area of the tree stems per unit area |
| | Mean DBH | Average stem diameter at breast height |
| | Stems per acre | Number of trees per acre |
| | Mean tree height | Average height of the trees |
| | Maximum tree height | Height of the tallest tree |
| Volume statistics | Ground cover volume | Vegetation volume from 0 to 1 m above the ground |
| | Understory volume | Vegetation volume from 1 to 3 m |
| | Midstory volume | Vegetation volume from 3 to 9 m |
| | Overstory volume | Vegetation volume above 9 m |
| Canopy statistics | Canopy base height | Height of the bottom of the canopy |
| | Canopy cover | Share of the plot covered by canopy |
| | Gap fraction | Share of the plot open to the sky: 1 − canopy cover |
| | Leaf area index (LAI) | The amount of one-sided green leaf area per unit of horizontal ground surface area |
| | Overstory, midstory, understory LAI | Leaf area index above 9 m, 3 to 9 m and 1 to 3 m |

Tree statistics come from the stems detected in the scan, corrected for
trees hidden from the scanner. Volumes and leaf area are calculated for each
height layer. See the **About** page for how scans are processed.

## Step by step

1. Download scans on the **Selection Map** and, if there was a treatment,
   enter its date on **Set Treatments**.
2. Pick a metric in each of the **Tree**, **Volume** and **Canopy
   statistics** lists.
3. Choose a **Plot type** and a **Data type**.
4. Turn **Treatment date lines** and **Error bars** on or off.
5. To look closer at a graph, use the controls along its bottom edge (see
   below): enlarge it, switch to its statistics, add it to the report or
   download it.

## How scans are grouped: time steps

The graphs and statistics group scans into **time steps**, one for each round
of scanning. The scans are taken in date order, and a new time step starts
when:

1. a **treatment date** falls between two scan dates, so pre- and
   post-treatment scans are never mixed;
2. a plot already scanned in the current step is **scanned again**, which
   marks a new round of scanning; or
3. more than **30 days** pass since the previous scan.

Each time step is labeled with the average date of its scans.

## Plot types

| Time series | Time series individual plot |
|---|---|
| ![Time series of basal area: the mean of each time step joined by a line, with error bars and a red treatment line](static/help/images/plot-type-timeseries.png) | ![One line per plot, colored by site and plot, with a legend](static/help/images/plot-type-individual.png) |
| **Box and Whisker** | **Bar** |
| ![A box and whisker for each time step, with each scan drawn as a point](static/help/images/plot-type-boxplot.png) | ![A bar for the mean of each time step, with error bars](static/help/images/plot-type-bar.png) |

- **Time series**: the mean of each time step, joined by a line. Error bars
  show the spread or precision of each mean.
- **Time series individual plot**: one line for each plot, colored by
  site and plot, so you can follow each plot through time. Points are spread
  slightly sideways so scans on the same date don't hide each other (not
  recommended for very large numbers of plots).
- **Box and Whisker**: for each time step, the box covers the middle half
  of the values, the line inside it is the median and the whiskers reach
  the furthest values within 1.5 times the box's height. Each scan is drawn
  as a point, including any beyond the whiskers.
- **Bar**: the mean of each time step as a bar, with error bars.

## Data type: values or percent change

<div class="help-shot"><img src="static/help/images/data-type-percent.png" alt="Basal area as percent change from each plot's first scan, with a dashed zero line" width="290"></div>

- **Values** shows the metric in its own units.
- **Percent change** shows the change from **each plot's own first scan**,
  so every plot starts at 0%. A dashed line marks 0. This puts plots with
  different starting values on the same footing, and the title and axis
  add "(% change)".

Plots whose first value is zero or missing are left out of percent change,
because change from zero can't be calculated.

## Error bars

- **SD** (standard deviation): how much individual data points vary or
  scatter around the mean.
- **SE** (standard error, SD / √n): how precisely the mean of the time step
  is known. It shrinks as more plots are scanned.
- **Off**: no error bars.

A time step with a single scan has no error bar.

## Card controls

Move the mouse over a graph to show its controls along the bottom edge.

<div class="help-shot"><img src="static/help/images/standard-outputs-card-controls.png" alt="A graph card with its controls showing: Expand, Graph and Statistics, + Report data and Download" width="290">
<span class="help-spot tip-right tip-up" tabindex="0" style="left:7.6%;top:91%">1<span class="help-tip"><b>Expand.</b> Shows the card full screen. Press <b>Close</b> to return.</span></span>
<span class="help-spot tip-right tip-up" tabindex="0" style="left:22%;top:80%">2<span class="help-tip"><b>Graph / Statistics.</b> Switches between the graph and a table of statistics.</span></span>
<span class="help-spot tip-left tip-up" tabindex="0" style="left:67%;top:80%">3<span class="help-tip"><b>+ Report data.</b> Adds what the card shows to the report.</span></span>
<span class="help-spot tip-left tip-up" tabindex="0" style="left:88%;top:80%">4<span class="help-tip"><b>Download.</b> The data as CSV, or the graph as an SVG or PNG image.</span></span>
</div>

1. **Expand**: shows the card full screen; press **Close** to return.
2. **Graph / Statistics**: switches between the graph and its statistics.
3. **+ Report data**: adds the graph or table to the report.
4. **Download**: saves the data or an image.

### Statistics

<div class="help-shot"><img src="static/help/images/card-statistics-view.png" alt="The Statistics view: one row per time step with n, min, max, mean, median, mode and SD" width="290"></div>

The Statistics view lists one row per time step:

| Column | Meaning |
|---|---|
| Time step | The average date of the scans in the step |
| n | Number of scans |
| Min, Max | Smallest and largest value |
| Mean, Median | Average and middle value |
| Mode | Most frequent value, to 3 significant figures; — when no value repeats |
| SD | Standard deviation; — for a step with a single scan |

The table follows the **Data type**: with percent change selected, it
describes percent change.

### Download

<div class="help-shot"><img src="static/help/images/card-download-menu.png" alt="The Download menu open with CSV data, SVG image and PNG image" width="290"></div>

- **CSV data**: one row per scan (site, plot, date, time step and value),
  whatever plot type is showing. Open it in a spreadsheet or statistical
  analysis software to run your own analysis.
- **SVG image** and **PNG image**: the graph redrawn on a white background
  for documents and slides. SVG stays sharp at any size; PNG is an image at
  200 dpi.

### + Report data

<div class="help-shot"><img src="static/help/images/card-report-added.png" alt="Message: Figure added to the report (8 items): Basal area (Basalarea)" width="250"></div>

Click **+ Report data** to add the card to the report. It adds whatever the
card is showing: the graph, or the statistics table in Statistics view. The
plot type, data type and other settings are recorded with it, along with an
automated description of the change over time. A message confirms the
addition. Arrange the report on the **Report builder** tab.

## Points2Pano viewer

The fourth card shows the Points2Pano panorama of a selected scan: a 360°
view made from the scan's points.

- The label at the top shows the site, plot, scan date and scanner.
- Use **◀** and **▶** to step through the selected scans.
- **+ Report data** adds an image of the default view of the plot to the
  report.
- In a narrow window, part of the card's top bar can be cut off. Use the
  card's **Expand** button to see all of its buttons.

## Things to know

- **The settings apply to every graph on this tab.** Each tab has its own
  settings, so changing them here doesn't change cards in Custom models or
  rothRmel.
- **Treatment dates matter.** Without them, pre- and post-treatment scans
  can share a time step if they were collected close together. Enter them on
  **Set Treatments** before you evaluate the results.
- **Means pool every loaded plot.** The time series, bar and statistics
  combine all loaded scans in each time step, across sites and units. Load
  only the plots you want to compare, or use **Time series individual plot**
  to see each plot separately.
- **Few plots, wide error bars.** With only a few plots per time step, the
  SD and SE are uncertain. The report's "Sample size and design" section
  lists these issues.
