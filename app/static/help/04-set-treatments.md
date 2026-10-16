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
- **Remeasurement numbers** count the visits to each plot: 0 for the first
  scan, 1 for the first remeasurement, and so on. They are set
  automatically, and you can correct them here.

The table has one row per scan:

| Column | Meaning |
|---|---|
| site, plot | Where the scan was taken |
| date | When the scan was taken |
| scanner_id | The scanner type used to take the scan |
| Unit | The management unit name ("My Unit" until you name it) |
| Remeasurement | The visit number: 0 for the initial scan |

## The screen at a glance

Move the mouse over a numbered marker, or press Tab to step through them, to
see what each part does.

<div class="help-shot"><img src="static/help/images/set-treatments-overview.png" alt="The Set Treatments tab: the scan table on the left, and the Add Treatment Dates and Set Unit Name or Remeasurement panels on the right" width="800">
<span class="help-spot tip-right" tabindex="0" style="left:28.5%;top:18.5%">1<span class="help-tip"><b>Column headings.</b> Sort the table by heading type: click one to sort by that column; click again to reverse the order.</span></span>
<span class="help-spot tip-right" tabindex="0" style="left:49.5%;top:24.5%">2<span class="help-tip"><b>Column filters.</b> Type or pick a value to show only the matching rows.</span></span>
<span class="help-spot tip-left" tabindex="0" style="left:63.5%;top:11%">3<span class="help-tip"><b>Search.</b> Shows only rows with this text in any column.</span></span>
<span class="help-spot tip-right" tabindex="0" style="left:37.5%;top:35.5%">4<span class="help-tip"><b>Scans.</b> Click a row to select it; click it again to unselect it. Select rows before you click Assign.</span></span>
<span class="help-spot tip-right" tabindex="0" style="left:52.5%;top:51%">5<span class="help-tip"><b>Unit.</b> Every scan starts in "My Unit". Give your units their own names.</span></span>
<span class="help-spot tip-left" tabindex="0" style="left:64.5%;top:61.5%">6<span class="help-tip"><b>Remeasurement.</b> The visit number of each scan, starting at 0.</span></span>
<span class="help-spot tip-left" tabindex="0" style="left:58.5%;top:4.6%">7<span class="help-tip"><b>Clear selection.</b> Unselects every row in the table.</span></span>
<span class="help-spot tip-left" tabindex="0" style="left:95%;top:28%">8<span class="help-tip"><b>Select Date.</b> Opens a calendar to pick a treatment date.</span></span>
<span class="help-spot tip-left" tabindex="0" style="left:95%;top:33.5%">9<span class="help-tip"><b>Add Date.</b> Adds the date to the Treatment Dates list.</span></span>
<span class="help-spot tip-left" tabindex="0" style="left:87.5%;top:50.5%">10<span class="help-tip"><b>Treatment Dates.</b> The dates added so far. Click a date to select it, then the trash can above the list to delete it.</span></span>
<span class="help-spot tip-left tip-up" tabindex="0" style="left:95%;top:88.5%">11<span class="help-tip"><b>Unit Name.</b> The name to give the selected scans.</span></span>
<span class="help-spot tip-left tip-up" tabindex="0" style="left:95%;top:97%">12<span class="help-tip"><b>Scan Remeasurement.</b> The number to give the selected scans. The <b>Assign</b> button is below it.</span></span>
</div>

1. **Column headings**: sort the table by heading type.
2. **Column filters**: show only matching rows.
3. **Search**: find text in any column.
4. **Scans**: click rows to select them.
5. **Unit**: the management unit of each scan.
6. **Remeasurement**: the visit number of each scan.
7. **Clear selection**: unselect all rows.
8. **Select Date**: pick a treatment date.
9. **Add Date**: add it to the list.
10. **Treatment Dates**: the dates added so far, with the trash can to
    delete treatments that are selected.
11. **Unit Name**: the name to assign.
12. **Scan Remeasurement**: the number to assign, then **Assign**.

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
<span class="help-spot tip-right" tabindex="0" style="left:13%;top:24.5%">1<span class="help-tip"><b>Filter</b> the site column to CASDU so only that site's scans are listed.</span></span>
<span class="help-spot tip-right" tabindex="0" style="left:14%;top:18.5%">2<span class="help-tip">The arrow shows the table is <b>sorted</b> by site.</span></span>
<span class="help-spot tip-right" tabindex="0" style="left:37.5%;top:46%">3<span class="help-tip"><b>Selected rows</b> are highlighted. Click each row you want to name.</span></span>
<span class="help-spot tip-left tip-up" tabindex="0" style="left:95%;top:81%">4<span class="help-tip">Type the <b>unit name</b>.</span></span>
<span class="help-spot tip-left tip-up" tabindex="0" style="left:95%;top:94.5%">5<span class="help-tip">Click <b>Assign</b> to give the selected scans the name.</span></span>
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

Add one date for each treatment. If the date is already in the list, a
"Date already added" warning appears.

<div class="help-shot"><img src="static/help/images/set-treatments-date-added.png" alt="After adding 2025-05-15: the date is listed under Treatment Dates, and scans after it have higher remeasurement numbers" width="800">
<span class="help-spot tip-left" tabindex="0" style="left:95%;top:20.5%">1<span class="help-tip">The <b>treatment date</b> picked in the calendar: 2025-05-15.</span></span>
<span class="help-spot tip-left" tabindex="0" style="left:95%;top:26%">2<span class="help-tip"><b>Add Date</b> was clicked.</span></span>
<span class="help-spot tip-left" tabindex="0" style="left:80%;top:37.5%">3<span class="help-tip">The date is now in the <b>Treatment Dates</b> list.</span></span>
<span class="help-spot tip-left" tabindex="0" style="left:64.5%;top:61.5%">4<span class="help-tip">Burn Unit A scans after the burn went from 0 to <b>1</b>: they are now post-treatment remeasurements.</span></span>
<span class="help-spot tip-left" tabindex="0" style="left:64.5%;top:46%">5<span class="help-tip">Thin Unit B scans went up too, because a treatment date applies to <b>every</b> loaded scan. Correct them by hand if that unit wasn't treated then.</span></span>
</div>

When you add a date:

- Scans collected on or after it get a higher **Remeasurement** number than
  the scans before it, when the two would otherwise share a number.
- On the graph tabs, scans after the date start a new time step, so pre-
  and post-treatment values are compared, and a treatment line marks the
  date.
- The report lists the date in its "Scans, plots and treatments" section.

<p class="help-warning"><strong>A treatment date applies to every loaded
scan, in every unit. If you load units treated at different times, check the
Remeasurement numbers after adding the dates and correct them where needed.</strong></p>

## Correct remeasurement numbers

<div class="help-shot"><img src="static/help/images/set-treatments-sort-remeasurement.png" alt="The table sorted by Unit, three Thin Unit B scans from 2025 selected, and 0 typed as the remeasurement number" width="800">
<span class="help-spot tip-left" tabindex="0" style="left:50.5%;top:18.5%">1<span class="help-tip">The table is <b>sorted by Unit</b>, so each unit's scans are listed together.</span></span>
<span class="help-spot tip-right" tabindex="0" style="left:37.5%;top:67%">2<span class="help-tip">The three Thin Unit B scans from 2025 are <b>selected</b>.</span></span>
<span class="help-spot tip-left tip-up" tabindex="0" style="left:95%;top:81%">3<span class="help-tip"><b>Unit Name</b> is left empty, so the unit names don't change.</span></span>
<span class="help-spot tip-left tip-up" tabindex="0" style="left:95%;top:89%">4<span class="help-tip">The new <b>remeasurement number</b>: 0, the initial scan.</span></span>
<span class="help-spot tip-left tip-up" tabindex="0" style="left:95%;top:94.5%">5<span class="help-tip">Click <b>Assign</b> to apply it.</span></span>
</div>

Remeasurement numbers are set for you: when you click **Get Data**, scans
are numbered by year (0 for the first year, 1 for the next, and so on), and
adding a treatment date raises the numbers of the later scans. To change
them:

1. Sort or filter the table so the scans to change are easy to find, for
   example by clicking the **Unit** heading (1).
2. Select the scans (2).
3. Leave **Unit Name** empty (3) so the names stay as they are.
4. Type the number in **Scan Remeasurement** (4): 0 for the initial scan,
   1 for the first remeasurement, and so on.
5. Click **Assign** (5).

You can also double-click a single **Remeasurement** cell, type the number
and press **Enter**.

The result for the example, with each unit numbered from its own first
visit:

<div class="help-shot"><img src="static/help/images/set-treatments-final.png" alt="Both units named and numbered: initial scans are 0 and remeasurements are 1" width="800">
<span class="help-spot tip-right" tabindex="0" style="left:55%;top:35.5%">1<span class="help-tip">Every scan has its <b>unit name</b>.</span></span>
<span class="help-spot tip-left" tabindex="0" style="left:64%;top:41%">2<span class="help-tip">Each unit's <b>initial scans</b> are numbered 0.</span></span>
<span class="help-spot tip-left" tabindex="0" style="left:64%;top:72%">3<span class="help-tip">Each unit's <b>remeasurements</b> are numbered 1.</span></span>
</div>

## Delete a treatment date

<div class="help-shot"><img src="static/help/images/set-treatments-delete-date.png" alt="The 2025-05-15 treatment date selected in the list, with the trash can above it" width="200">
<span class="help-spot tip-left" tabindex="0" style="left:77.5%;top:63.5%">1<span class="help-tip">Then click the <b>trash can</b> to delete it.</span></span>
<span class="help-spot tip-right" tabindex="0" style="left:35%;top:77%">2<span class="help-tip">First click the <b>date</b> to select it.</span></span>
</div>

1. Click the date in the **Treatment Dates** list to select it.
2. Click the **trash can** above the list.

To change a date, delete it and add the correct one. Deleting a date doesn't
change the remeasurement numbers back; correct them by hand if needed.

## Things to know

- **Treatment dates are shared by all loaded scans.** One list of dates
  applies to every site and unit; there is no separate list per unit.
- **Download first, then number.** Clicking **Get Data** on the Selection
  Map renumbers every loaded scan by year, which replaces remeasurement
  numbers you set by hand. Unit names are kept. Finish downloading before
  correcting the numbers.
- **The table needs downloaded scans.** If you selected plots but didn't
  click **Get Data**, the table shows a message asking you to go back to the
  Selection Map.
- **Units and numbers last for one session.** Reloading the page clears
  them along with the downloaded data.
- **Clearing plots on the Selection Map** removes them from this table too.
