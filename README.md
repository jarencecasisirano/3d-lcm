# Bosnia Land Cover Visualization

## Overview

This project showcases a 3D land cover visualization of Bosnia and Herzegovina using R. By combining satellite-derived land cover data with digital elevation models, the script produces a high-quality, interactive visualization. The goal is to highlight the region's diverse land cover types and topography in an engaging format.

The final 3D rendering was inspired by Milos Popovic's excellent tutorial on 3D mapping in R, available on his YouTube channel, [Milos Makes Maps](https://www.youtube.com/watch?v=y_Kzg24Ciuo&ab_channel=MilosMakesMaps).

---

## Description

The R script processes the following:

1. **Land Cover Data**: Downloads and processes satellite imagery to classify land cover types.
2. **Elevation Data**: Integrates elevation data to add realistic depth and perspective.
3. **Rendering**: Combines land cover and elevation information to create a 3D visualization using the `rayshader` package.

---

## Output

### Final Visualization

![Bosnia Land Cover 3D](3d_bosnia_land_cover_final.png)

The above image illustrates Bosnia's land cover types, including forests, water bodies, and built-up areas, with realistic elevation effects.

---

## Credits

- **Tutorial**: Milos Popovic's [3D Mapping in R Tutorial](https://www.youtube.com/watch?v=y_Kzg24Ciuo&ab_channel=MilosMakesMaps).
- **Data Sources**: ESRI Land Cover tiles and elevation data from publicly available datasets.
- **Packages Used**: This project utilizes open-source R libraries, including `rayshader` and `terra`.

---

For detailed implementation, refer to the [R script](3d-lcm.R) included in this repository.
