# Set Treatments

## What this tab is for

Set Treatments lists the scans downloaded from the Selection Map. This tab is
used to examine the scans that have been downloaded and provide context to
them.

- **Treatment dates** record when a treatment, such as a prescribed burn or
  a thinning, took place. The graph tabs use them to separate pre- and
  post-treatment scans into different time steps and draw them as
  treatment lines. They are also used in the report builder to provide
  context to the analysis.
- **Management unit names** group plots into the units you manage, such as
  "Burn Unit A".
- **Remeasurement numbers** count the visits to each plot: 0 for its first
  scan, 1 for its next scan, and so on, however close together the scans
  are. They are set automatically, and you can correct them here.
- **Scan groupings** gather the scans from one round of scanning into a
  time step. The graph tabs and the report compare scan groupings, so they
  decide which scans are averaged together. They are set automatically, and
  any you change here are used on every graph tab and in the report.

The table has one row per scan:

| Column | Meaning |
|---|---|
| site, plot | Where the scan was taken |
| date | When the scan was taken |
| scanner_id | The scanner type used to take the scan |
| Unit | The management unit name ("My Unit" until you name it) |
| Remeasurement | The visit number of the plot: 0 for its first scan |
| Scan grouping | The time step the scan belongs to, from 1 |

## The screen at a glance

Move the mouse over a numbered marker, or press Tab to step through them, to
see what each part does.

<div class="help-shot"><img src="static/help/images/set-treatments-overview.png" alt="The Set Treatments tab: the scan table on the left, and the Add Treatment Dates and Set Unit Name, Remeasurement or Scan Grouping panels on the right" width="800">
<span class="help-spot tip-right" tabindex="0" style="left:26.9%;top:16.7%">1<span class="help-tip"><b>Column headings.</b> Sort the table by heading type: click one to sort by that column; click again to reverse the order.</span></span>
<span class="help-spot tip-right" tabindex="0" style="left:48.3%;top:21.3%">2<span class="help-tip"><b>Column filters.</b> Type or pick a value to show only the matching rows.</span></span>
<span class="help-spot tip-left" tabindex="0" style="left:74%;top:8.1%">3<span class="help-tip"><b>Search.</b> Shows only rows with this text in any column.</span></span>
<span class="help-spot tip-right" tabindex="0" style="left:37.5%;top:34.7%">4<span class="help-tip"><b>Scans.</b> Click a row to select it; click it again to unselect it. Select rows before you click Assign.</span></span>
<span class="help-spot tip-right" tabindex="0" style="left:48.1%;top:43.1%">5<span class="help-tip"><b>Unit.</b> Every scan starts in "My Unit". Give your units their own names.</span></span>
<span class="help-spot tip-left" tabindex="0" style="left:56.9%;top:51.6%">6<span class="help-tip"><b>Remeasurement.</b> The visit number of each plot, starting at 0: each plot here was scanned twice, so its scans are 0 and 1.</span></span>
<span class="help-spot tip-left" tabindex="0" style="left:68.5%;top:59.8%">7<span class="help-tip"><b>Scan grouping.</b> The time step of each scan, starting at 1. The graph tabs and the report average the scans of each grouping together.</span></span>
<span class="help-spot tip-left" tabindex="0" style="left:62.5%;top:2.9%">8<span class="help-tip"><b>Clear selection.</b> Unselects every row in the table.</span></span>
<span class="help-spot tip-left" tabindex="0" style="left:95%;top:26.6%">9<span class="help-tip"><b>Select Date.</b> Opens a calendar to pick a treatment date.</span></span>
<span class="help-spot tip-left" tabindex="0" style="left:96.25%;top:30.8%">10<span class="help-tip"><b>Add Date.</b> Adds the date to the Treatment Dates list.</span></span>
<span class="help-spot tip-left" tabindex="0" style="left:96.25%;top:40%">11<span class="help-tip"><b>Treatment Dates.</b> The dates added so far. Click a date to select it, then the trash can above the list to delete it.</span></span>
<span class="help-spot tip-left tip-up" tabindex="0" style="left:95%;top:78.2%">12<span class="help-tip"><b>Unit Name.</b> The name to give the selected scans.</span></span>
<span class="help-spot tip-left tip-up" tabindex="0" style="left:95%;top:84.8%">13<span class="help-tip"><b>Scan Remeasurement.</b> The remeasurement number to give the selected scans.</span></span>
<span class="help-spot tip-left tip-up" tabindex="0" style="left:95%;top:91.2%">14<span class="help-tip"><b>Scan Grouping.</b> The scan grouping to give the selected scans. The <b>Assign</b> button is below it.</span></span>
</div>

1. **Column headings**: sort the table by heading type.
2. **Column filters**: show only matching rows.
3. **Search**: find text in any column.
4. **Scans**: click rows to select them.
5. **Unit**: the management unit of each scan.
6. **Remeasurement**: the visit number of each plot.
7. **Scan grouping**: the time step of each scan.
8. **Clear selection**: unselect all rows.
9. **Select Date**: pick a treatment date.
10. **Add Date**: add it to the list.
11. **Treatment Dates**: the dates added so far, with the trash can to
    delete treatments that are selected.
12. **Unit Name**: the name to assign.
13. **Scan Remeasurement**: the remeasurement number to assign.
14. **Scan Grouping**: the scan grouping to assign, then **Assign**.

## Sorting and filtering the table

Sorting and filtering only change what you see. They help you find and
select scans for management unit assignment or to choose management dates.

- **Sort:** click a column heading. The arrow shows the direction; click
  again to reverse it. Hold **Shift** and click a second heading to sort by
  both columns. The table starts sorted by date, then site, then plot.
- **Filter:** click the box under a column heading and type or pick a
  value. Only matching rows stay in the table. Clear the box, or click the
  ⊗ under it, to show every row again.
- **Search:** type in the **Search** box above the table to keep the rows
  that contain the text in any column.

After you click **Assign** or **Add Date**, the table is redrawn: the sort
order, the filters and the selected rows go back to their defaults.

## Name management units

<div class="help-shot"><img src="static/help/images/set-treatments-assign-unit.png" alt="The table filtered to site CASDU, all six CASDU scans selected, and Burn Unit A typed as the unit name" width="800">
<span class="help-spot tip-right" tabindex="0" style="left:8.25%;top:21.3%">1<span class="help-tip"><b>Filter</b> the site column to CASDU so only that site's scans are listed.</span></span>
<span class="help-spot tip-right" tabindex="0" style="left:6.9%;top:15.4%">2<span class="help-tip">The arrow shows the table is <b>sorted</b> by site.</span></span>
<span class="help-spot tip-right" tabindex="0" style="left:37.5%;top:37.2%">3<span class="help-tip"><b>Selected rows</b> are highlighted. Click each row you want to name.</span></span>
<span class="help-spot tip-left tip-up" tabindex="0" style="left:95%;top:78.2%">4<span class="help-tip">Type the <b>unit name</b>.</span></span>
<span class="help-spot tip-left tip-up" tabindex="0" style="left:95%;top:95.4%">5<span class="help-tip">Click <b>Assign</b> to give the selected scans the name.</span></span>
</div>

1. Narrow the table to the scans of one unit, for example by filtering the
   **site** column (1) or sorting by site (2).
2. Click each scan of the unit to select it (3). Selected rows are
   highlighted. Click a row again to unselect it, or use **Clear
   selection** to start over.
3. Type the name in **Unit Name** (4).
4. Click **Assign** (5). The name appears in the **Unit** column of every
   selected scan.

Repeat for each unit. You can also double-click a single **Unit** cell, type
a new name and press **Enter** (or click elsewhere) to change one scan.

**Naming tips**

- Be precise in the naming of your management unit; this unit name is used
  in the Report builder as printed here.
- Spell a unit's name exactly the same way every time. "Unit A" and "unit A"
  are counted as two different units.
- Give every scan of a plot the same unit, so the report lists the plot
  under one unit.
- Scans left as "My Unit" are treated as not assigned to a unit.

## Add treatment dates

<div class="help-shot"><img src="static/help/images/set-treatments-calendar.png" alt="The Select Date calendar open on October 2026" width="200"></div>

1. Click the **Select Date** box. A calendar opens.
2. Use **«** and **»** to change the month, or click the month name to jump
   between months and years. Click the day of the treatment.
3. Alternatively, edit the date in the date box in YYYY-MM-DD format.
4. Click **Add Date**. The date appears in the **Treatment Dates** list.

Adding or deleting a date regroups every scan, which replaces any scan
groupings you entered by hand. Add your treatment dates before correcting
scan groupings.

Add one date for each treatment. If the date is already in the list, a
"Date already added" warning appears.

<div class="help-shot"><img src="static/help/images/set-treatments-date-added.png" alt="After adding 2025-05-15: the date is listed under Treatment Dates" width="800">
<span class="help-spot tip-left" tabindex="0" style="left:95%;top:26.6%">1<span class="help-tip">The <b>treatment date</b> picked in the calendar: 2025-05-15.</span></span>
<span class="help-spot tip-left" tabindex="0" style="left:96.25%;top:30.8%">2<span class="help-tip"><b>Add Date</b> was clicked.</span></span>
<span class="help-spot tip-left" tabindex="0" style="left:89%;top:40%">3<span class="help-tip">The date is now in the <b>Treatment Dates</b> list.</span></span>
<span class="help-spot tip-left" tabindex="0" style="left:56.9%;top:43.1%">4<span class="help-tip"><b>Remeasurement</b> numbers don't change: they count each plot's visits, before or after a treatment.</span></span>
<span class="help-spot tip-left" tabindex="0" style="left:68.5%;top:51.6%">5<span class="help-tip"><b>Scan grouping.</b> Scans after the date start a new grouping. Here more than 30 days already separated them, so the groupings stay 1 to 4.</span></span>
</div>

When you add a date:

- Scans collected on or after it start a new **Scan grouping**, so on the
  graph tabs and in the report pre- and post-treatment values are compared,
  and a treatment line marks the date.
- **Remeasurement** numbers don't change: they count visits to each plot,
  whether or not a treatment came between them.
- The report lists the date in its "Scans, plots and treatments" section.

<p class="help-warning"><strong>A treatment date applies to every loaded
scan, in every unit. If you load units treated at different times, check the
Scan grouping after adding the dates and correct it where needed.</strong></p>

## Correct remeasurement numbers

Remeasurement numbers are set for you when you click **Get Data**: each
plot's scans are numbered in date order, 0 for its first scan, 1 for its
next and so on, even when the next scan is the following day. Scans of a
plot taken on the same date share a number. To change them:

1. Sort or filter the table so the scans to change are easy to find, for
   example by clicking the **plot** heading.
2. Select the scans.
3. Leave **Unit Name** and **Scan Grouping** empty so they stay as they
   are.
4. Type the number in **Scan Remeasurement**: 0 for the plot's first scan,
   1 for its next, and so on.
5. Click **Assign**.

You can also double-click a single **Remeasurement** cell, type the number
and press **Enter**.

## Scan grouping

The graph tabs and the report don't compare scans one date at a time.
They gather the scans from one round of scanning into a **scan grouping**
(shown on the graphs as a time step) and compare the groupings. When you
click **Get Data**, scans are grouped by walking through the scan dates in
order. A new scan grouping starts when:

1. a **treatment date** falls between one scan date and the next;
2. a plot already scanned in the current grouping is **scanned again**,
   which marks a new round of scanning; or
3. more than **30 days** pass since the previous scan.

Plots scanned only once stay in the grouping that was open when they were
scanned. Groupings are numbered from 1 in date order; on the graphs each one
is labeled with the average date of its scans.

<div class="help-shot"><img src="static/help/images/set-treatments-scan-grouping.png" alt="The table sorted by Remeasurement, the six initial scans selected, and 1 typed as the scan grouping" width="800">
<span class="help-spot tip-right" tabindex="0" style="left:56.9%;top:13.2%">1<span class="help-tip">The table is <b>sorted by Remeasurement</b>, so the initial scans of both units are listed together.</span></span>
<span class="help-spot tip-right" tabindex="0" style="left:37.5%;top:38.9%">2<span class="help-tip">The six <b>initial scans</b> are selected. By default they were split into scan groupings 1 and 2.</span></span>
<span class="help-spot tip-left tip-up" tabindex="0" style="left:95%;top:81.7%">3<span class="help-tip"><b>Unit Name</b> and <b>Scan Remeasurement</b> are left empty, so they don't change.</span></span>
<span class="help-spot tip-left tip-up" tabindex="0" style="left:95%;top:91.2%">4<span class="help-tip">The new <b>scan grouping</b>: 1.</span></span>
<span class="help-spot tip-left tip-up" tabindex="0" style="left:95%;top:95.4%">5<span class="help-tip">Click <b>Assign</b> to apply it.</span></span>
</div>

To change the grouping, for example to keep a round of scanning that ran
longer than 30 days together, or to separate units treated at different
times:

1. Sort or filter the table so the scans to change are easy to find, for
   example by clicking the **Remeasurement** heading (1).
2. Select the scans (2).
3. Leave **Unit Name** and **Scan Remeasurement** empty (3) so they stay as
   they are.
4. Type the number in **Scan Grouping** (4). Scans with the same number are
   averaged together.
5. Click **Assign** (5).

In the example, the four rounds of scanning (two per unit) are regrouped so
the graphs compare all initial scans (grouping 1) with all remeasurements
(grouping 2):

<div class="help-shot"><img src="static/help/images/set-treatments-final.png" alt="Both units named; remeasurements are 0 and 1 for each plot, and scan groupings are 1 for initial scans and 2 for remeasurements" width="800">
<span class="help-spot tip-right" tabindex="0" style="left:50%;top:38.9%">1<span class="help-tip">Every scan has its <b>unit name</b>.</span></span>
<span class="help-spot tip-left" tabindex="0" style="left:56.9%;top:43.1%">2<span class="help-tip">Each plot's <b>remeasurement</b> numbers: 0 for its first scan, 1 for its next.</span></span>
<span class="help-spot tip-left" tabindex="0" style="left:68.5%;top:38.9%">3<span class="help-tip">The <b>initial scans</b> of both units are scan grouping 1.</span></span>
<span class="help-spot tip-left" tabindex="0" style="left:68.5%;top:59.8%">4<span class="help-tip">The <b>remeasurements</b> of both units are scan grouping 2.</span></span>
</div>

You can also double-click a single **Scan grouping** cell, type the number
and press **Enter**.

Your changes are used on every graph tab (Standard outputs, Custom models
and rothRmel) and in the report. The numbers only label the groupings: the
graphs order them by date, and a number you skip doesn't add an empty time
step.

## Delete a treatment date

<div class="help-shot"><img src="static/help/images/set-treatments-delete-date.png" alt="The 2025-05-15 treatment date selected in the list, with the trash can above it" width="200">
<span class="help-spot tip-left" tabindex="0" style="left:77.5%;top:63.5%">1<span class="help-tip">Then click the <b>trash can</b> to delete it.</span></span>
<span class="help-spot tip-right" tabindex="0" style="left:35%;top:77%">2<span class="help-tip">First click the <b>date</b> to select it.</span></span>
</div>

1. Click the date in the **Treatment Dates** list to select it.
2. Click the **trash can** above the list.

To change a date, delete it and add the correct one. Deleting a date
regroups every scan, which replaces scan groupings you entered by hand;
remeasurement numbers are kept.

## Things to know

- **Treatment dates are shared by all loaded scans.** One list of dates
  applies to every site and unit; there is no separate list per unit.
- **Download first, then number.** Clicking **Get Data** on the Selection
  Map renumbers and regroups every loaded scan, which replaces remeasurement
  numbers and scan groupings you set by hand. Unit names are kept. Finish
  downloading and adding treatment dates before correcting the numbers.
- **The table needs downloaded scans.** If you selected plots but didn't
  click **Get Data**, the table shows a message asking you to go back to the
  Selection Map.
- **Units and numbers last for one session.** Reloading the page clears
  them along with the downloaded data.
- **Clearing plots on the Selection Map** removes them from this table too.
