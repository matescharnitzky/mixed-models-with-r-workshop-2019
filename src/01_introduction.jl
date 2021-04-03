
# installing packages
import Pkg
Pkg.add("CSV")
Pkg.add("DataFrames")
Pkg.add("MixedModels")
Pkg.add("TableView")

# load packages
using CSV
using DataFrames
using MixedModels
using TableView

# read csv
df = DataFrame(CSV.File("./data/sleepstudy.csv"))

# inspect df
first(df, 5)
showtable(df)
describe(df)

# change column type
transform!(df, :Subject => categorical, renamecols=false)

# fit mixed model
mixed_model = fit(MixedModel, @formula(Reaction ~ Days + (Days|Subject)), df, REML=true)
