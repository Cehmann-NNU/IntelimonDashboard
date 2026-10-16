# Selection Map

## What this tab is for

The Selection Map is used to identify and download the data records that
will be available for analysis throughout the application. Plot locations
available through the IntELiMon API, along with any selected local data, are
displayed on the map and color-coded by agency.

Use the map controls to filter plots by agency and scan date, select plots
for analysis, and download the associated data into the current session.
Data downloaded from this tab populate the following tabs:

- Set Treatments
- Standard Outputs
- Custom Models
- Fuels Exports
- Forestry Exports
- rothRmel
- Report Builder

A plot may be scanned multiple times, such as before and after treatment.
Each scan is stored as a separate record. The controls on this tab determine
which scan records are selected and downloaded.

- **Agency selection** limits displayed plots to one or more agencies.
- **Date range** limits displayed scans to a specified time period.
- **Point selection** selects individual plots. Selecting a plot includes
  all scans for that plot that fall within the current date range.
- **Get Data** downloads forestry, fuels, and ecological metrics; tree
  inventory data; and predictive-model outputs for the selected scans.

For local installations, scans may also be loaded from a folder using the
**Load Data** tab.

## The screen at a glance

Move the mouse over a numbered marker, or press Tab to step through them, to
see what each part does.

<div class="help-shot"><img src="static/help/images/selection-map-overview.png" alt="The Selection Map tab: the Select Scans panel on the left, and the map of all plots on the right" width="800">
<span class="help-spot tip-right" tabindex="0" style="left:21%;top:14.5%">1<span class="help-tip"><b>Agency selection.</b> Pick one or more agencies to show only their plots. Leave it empty to show every agency.</span></span>
<span class="help-spot tip-right" tabindex="0" style="left:21%;top:27%">2<span class="help-tip"><b>Select date range.</b> Drag either handle to show only scans collected between the two dates.</span></span>
<span class="help-spot tip-right" tabindex="0" style="left:21%;top:34.5%">3<span class="help-tip"><b>Clear All Plots.</b> Removes every plot from the selection so you can start choosing again.</span></span>
<span class="help-spot tip-right" tabindex="0" style="left:21%;top:39.5%">4<span class="help-tip"><b>Get Data.</b> Downloads the selected scans into your session. The other tabs use these data.</span></span>
<span class="help-spot tip-right" tabindex="0" style="left:28.5%;top:15.5%">5<span class="help-tip"><b>Zoom in and out.</b> You can also zoom with the mouse wheel and pan by dragging the map.</span></span>
<span class="help-spot tip-right" tabindex="0" style="left:28.5%;top:30%">6<span class="help-tip"><b>Draw rectangle/polygon.</b> Used to select multiple points.</span></span>
<span class="help-spot tip-left" tabindex="0" style="left:87%;top:14.5%">7<span class="help-tip"><b>Satellite or Base Map.</b> Switch between satellite imagery and a plain gray map. Markers are easier to see on the Base Map.</span></span>
<span class="help-spot tip-up" tabindex="0" style="left:48%;top:66%">8<span class="help-tip"><b>Legend.</b> The color of each agency's plots. Selected plots are gold; downloaded plots are blue.</span></span>
<span class="help-spot tip-left" tabindex="0" style="left:66%;top:54%">9<span class="help-tip"><b>Plots.</b> Each dot is a plot. Zoom in and click a dot to select it; click it again to unselect it.</span></span>
<span class="help-spot tip-right tip-up" tabindex="0" style="left:24.5%;top:95%">10<span class="help-tip"><b>Expand.</b> Shows the map full screen, partly hidden behind the legend in this corner. Press <b>Close</b> at the top right to return.</span></span>
</div>

1. **Agency selection**: shows only the chosen agencies' plots.
2. **Select date range**: shows only scans between the two dates.
3. **Clear All Plots**: empties the selection.
4. **Get Data**: downloads the selected scans.
5. **Zoom buttons**: zoom in and out (the mouse wheel works too).
6. **Draw rectangle/polygon**: used to select multiple points.
7. **Satellite / Base Map**: switches the background map.
8. **Legend**: agency colors, plus gold for selected and blue for
   downloaded plots.
9. **Plots**: click to select or unselect.
10. **Expand**: shows the map full screen.

## Step by step

### Step 1: Choose agencies (optional)

<div class="help-shot"><img src="static/help/images/selection-map-agency-list.png" alt="The Agency selection list open, showing agency names" width="400">
<span class="help-spot tip-right" tabindex="0" style="left:40%;top:26%">1<span class="help-tip">Click the box to open the list. You can also type part of a name to find an agency quickly.</span></span>
<span class="help-spot tip-right" tabindex="0" style="left:38%;top:45%">2<span class="help-tip">Click an agency to add it. The list stays open so you can add more.</span></span>
</div>

1. Click the **Agency selection** box. The agency names open in a drop down
   list.
2. Click an agency, or type part of its name and press **Enter**. Add as
   many agencies as you need.
3. Click anywhere outside the list, or press **Esc**, to close it.
4. To remove an agency, click its name in the box and press **Backspace** or
   **Delete**.

When the box is empty, plots from every agency are shown. After a change,
the map zooms to fit all the plots that match.

### Step 2: Set the date range (optional)

<div class="help-shot"><img src="static/help/images/selection-map-date-range.png" alt="The date range slider with its start handle moved to 2023-06-27" width="180"></div>

1. Drag the **left handle** to the earliest date you want.
2. Drag the **right handle** to the latest date you want.

The dates above the handles show the range. The slider moves in steps of
about a month (30 days). Only scans collected inside the range are shown on
the map and can be selected.

The figure below shows the map after both filters: only USDA Forest Service
plots scanned from June 2023 onward remain.

<div class="help-shot"><img src="static/help/images/selection-map-agency-filtered.png" alt="The map after choosing USDA Forest Service and moving the start date to 2023-06-27" width="760">
<span class="help-spot tip-right" tabindex="0" style="left:22.5%;top:16%">1<span class="help-tip">One agency chosen: only its plots are drawn.</span></span>
<span class="help-spot tip-right" tabindex="0" style="left:10%;top:37%">2<span class="help-tip">Start date moved later: scans collected before it are hidden.</span></span>
<span class="help-spot tip-left" tabindex="0" style="left:62%;top:42%">3<span class="help-tip">The map zooms to fit the plots that match both filters.</span></span>
</div>

### Step 3: Find your plots

- **Zoom** with the **+** and **−** buttons or the mouse wheel, and **pan**
  by dragging the map.
- Once you zoom in far enough, each plot shows its **plot number**. The
  numbers appear when no more than 80 plots are in view.
- Use the **Expand** button in the lower left corner of the map to work on a
  full-screen map.
- Switch to **Base Map** if the markers are hard to see on the satellite
  imagery.
- For a larger view, click the gray circle in the lower left corner of the
  map card to expand the map to full screen.

### Step 4: Select plots

<div class="help-shot"><img src="static/help/images/selection-map-selected.png" alt="A zoomed-in map with plot numbers; three plots are selected and drawn in gold" width="780">
<span class="help-spot tip-right" tabindex="0" style="left:46%;top:34%">1<span class="help-tip"><b>Selected plot</b> (gold). Click it again to unselect it.</span></span>
<span class="help-spot tip-right" tabindex="0" style="left:24%;top:46%">2<span class="help-tip"><b>Plot not selected</b>, drawn in its agency's color.</span></span>
<span class="help-spot tip-right" tabindex="0" style="left:31%;top:54%">3<span class="help-tip"><b>Plot number</b>, shown once you zoom in.</span></span>
<span class="help-spot tip-right" tabindex="0" style="left:12.5%;top:62.5%">4<span class="help-tip"><b>Selected</b> in the legend: gold marks the plots you picked.</span></span>
</div>

1. When a plot point is clicked, it turns **gold**: it is selected, together
   with all of its scans inside the date range.
2. Click more plots to add them. They can be anywhere on the map across
   sites and agencies.
3. To unselect a plot, click its dot again to revert it to its original
   color.

The dots are small. If a click doesn't select a plot, zoom in further and
click the center of the dot.

### Step 5: Get the data

<div class="help-shot"><img src="static/help/images/selection-map-progress.png" alt="Progress message: Getting data from 3 new scans at 3 plots" width="295"></div>

1. Click **Get Data**.
2. A progress message counts the scans and plots being downloaded. Each scan
   brings its metrics, tree inventory and predictive model outputs.
3. When it finishes, the downloaded plots turn **blue**.

<div class="help-shot"><img src="static/help/images/selection-map-downloaded.png" alt="Base Map view: three downloaded plots in blue among plots that were not selected" width="780">
<span class="help-spot tip-right" tabindex="0" style="left:45.5%;top:34%">1<span class="help-tip"><b>Downloaded plot</b> (blue): its scans are loaded and ready on the other tabs.</span></span>
<span class="help-spot tip-right" tabindex="0" style="left:14.5%;top:55.5%">2<span class="help-tip"><b>Downloaded</b> in the legend.</span></span>
<span class="help-spot tip-right" tabindex="0" style="left:23%;top:46%">3<span class="help-tip">A plot that was not selected keeps its agency color.</span></span>
<span class="help-spot tip-left" tabindex="0" style="left:88%;top:13.5%">4<span class="help-tip"><b>Base Map</b> chosen: the plain background makes the markers easy to see.</span></span>
</div>

You can now go on to **Set Treatments** to enter treatment dates, or straight
to the graph tabs.

To add more plots later, select them and click **Get Data** again. Only scans
that are not already downloaded are fetched; the new ones are added to the
data you already have.

### Step 6: Change or clear the selection

- Click a gold or blue plot to take it out of the selection.
- Click **Clear All Plots** to empty the selection and start again.

<div class="help-shot"><img src="static/help/images/selection-map-no-scans.png" alt="Warning: No scans selected. Click on a desired plot and set date range." width="293"></div>

If you click **Get Data** with nothing to download, this warning appears.
It also appears when every selected scan has already been downloaded.

## Map symbols

| Symbol | Meaning |
|---|---|
| Dot in an agency color | A plot that matches the filters; click to select it |
| Gold dot | A selected plot |
| Blue dot | A selected plot whose scans are downloaded |
| Number beside a dot | The plot number, shown when zoomed in |

## Things to know

- **Selecting a plot selects all of its scans in the date range.** To leave a
  scan out, for example a late re-scan, narrow the date range so the scan
  falls outside it.
- **Changing the agencies or dates updates the selection.** Selected scans
  that no longer match are dropped, and the map zooms to fit the plots that
  match. Set the filters first, then select plots.
- **Downloaded data stay loaded.** Clearing the selection or changing the
  filters doesn't delete scans that are already downloaded, and the graph
  tabs keep showing them. To start completely fresh, reload the page.
- **Data last for one session.** Reloading the page or closing the browser
  tab clears all selections and downloads.
- **New selections get default settings.** Each selected plot is placed in a
  management unit called "My Unit". When you click **Get Data**, its scans
  are numbered as remeasurements by year (0 for the first year, 1 for the
  next, and so on). Change both on the **Set Treatments** tab.
