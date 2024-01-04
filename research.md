---
layout: default
title: Research
group: "navigation"
order: 2
usemathjax: true
summary: A complete list of (co-)authored research.
tags: [Research, Working Paper]
---

# Research

## Working Papers

 **Optimal Categorical Instrumental Variables** ([arXiv](https://arxiv.org/abs/2311.17021); [Slides](/assets/pdfs/civ_w_slides.pdf); [R package](https://thomaswiemann.com/civ/)).

_Abstract._ This paper discusses estimation with a categorical instrumental variable in settings with potentially few observations per category. The proposed categorical instrumental variable estimator (CIV) leverages a regularization assumption that implies existence of a latent categorical variable with fixed finite support achieving the same first stage fit as the observed instrument. In asymptotic regimes that allow the number of observations per category to grow at arbitrary small polynomial rate with the sample size, I show that when the cardinality of the support of the optimal instrument is known, CIV is root-$n$ asymptotically normal, achieves the same asymptotic variance as the oracle IV estimator that presumes knowledge of the optimal instrument, and is semiparametrically efficient under homoskedasticity. Under-specifying the number of support points reduces efficiency but maintains asymptotic normality.  \
_Presented at: International Association for Applied Econometrics 2023_
\
\
**Demand Estimation with Finitely Many Consumers** ([Draft](/assets/pdfs/ezmpec_lw.pdf); [Slides](/assets/pdfs/ezmpec_lw_slides.pdf))\
with [Jonas Lieber](https://jonaslieber.com/index.html). 

_Abstract._ Although market shares are frequently estimated via averages of finitely many consumer choices, commonly applied methods for demand estimation are not robust to estimation error in these shares. While non-negligible estimation error in market shares always introduces bias in the demand parameter estimators, the issue becomes most salient when estimated market shares are zero. In the presence of zero shares, widely applied estimators of the random coefficient logit model cannot be computed without ad-hoc data manipulations. This paper proposes a new estimator of demand parameters for settings with endogenous prices and estimated market shares that is robust to zero-valued market shares. The estimator generalizes the constrained optimization program of Dubé et al. (2012) with probabilistic bounds on the estimation error in market shares. We show consistency as the number of markets $T$ grows sufficiently slowly relative to the number of consumers $n$ such that $\log(T)/n\to 0$, and provide confidence intervals under the same regime. Simulations suggest improved finite sample properties of the proposed estimator to conventional alternatives. \
_Presented at: Optimization Conscious Econometrics Conference 2023, North American Summer Meetings of the Econometric Society 2023_
\
\
**Effects of Health Care Policy Uncertainty on Households' Portfolio Choice** ([Draft](/assets/pdfs/hcpu_wl.pdf); [Slides](/assets/pdfs/hcpu_wl_slides.pdf))\
with [Robin L Lumsdaine](https://www.american.edu/kogod/faculty/lumsdain.cfm). _Submitted._ 

_Abstract._ This paper develops a nonparametric identification approach for causal effects of an endogenous macroeconomic variable on microeconomic outcomes. The key assumption is the existence of an exogenous variable that shifts responsiveness to the variable of interest without shifting responsiveness to other macroeconomic time series. We apply the approach  to study the effect of health care policy uncertainty (HCPU) on households’ portfolio choice using health shocks to capture cross-sectional heterogeneity. Under the additional assumption of risk averse agents, our approach provides an informative bound on the average causal effect of HCPU. The empirical results highlight HCPU as an important determinant of households’ financial behavior, and showcase substantial heterogeneity in HCPU effects across varying unexpected changes to health. \
_Presented at: Stanford Institute for Theoretical Economics 2019, International Association for Applied Econometrics 2019, Society for Financial Econometrics 2019, Royal Economic Society 2023_\
\
**ddml: Double/debiased machine learning in Stata** ([arXiv](https://arxiv.org/abs/2301.09397); [Stata package](https://statalasso.github.io/docs/ddml/); [R package](https://thomaswiemann.com/ddml/)) \
with [Achim Ahrens](https://achimahrens.de/), [Christian B Hansen](https://voices.uchicago.edu/christianhansen/), [Mark E Schaffer](https://ideas.repec.org/e/psc51.html). _Accepted at the Stata Journal._ 

_Abstract._ We introduce the package ddml for Double/Debiased Machine Learning (DDML) in Stata. Estimators of causal parameters for five different econometric models are supported, allowing for flexible estimation of causal effects of endogenous variables in settings with unknown functional forms and/or many exogenous variables. ddml is compatible with many existing supervised machine learning programs in Stata. We recommend using DDML in combination with stacking estimation which combines multiple machine learners into a final predictor. We provide Monte Carlo evidence to support our recommendation.\
\
**Model Averaging and Double Machine Learning** ([arXiv](https://arxiv.org/abs/2401.01645); [Stata package](https://statalasso.github.io/docs/ddml/); [R package](https://thomaswiemann.com/ddml/))\
with [Achim Ahrens](https://achimahrens.de/), [Christian B Hansen](https://voices.uchicago.edu/christianhansen/), [Mark E Schaffer](https://ideas.repec.org/e/psc51.html). 

_Abstract._ This paper discusses pairing double/debiased machine learning (DDML) with stacking, a model averaging method for combining multiple candidate learners, to estimate structural parameters. We introduce two new stacking approaches for DDML: short-stacking exploits the cross-fitting step of DDML to substantially reduce the computational burden and pooled stacking enforces common stacking weights over cross-fitting folds. Using calibrated simulation studies and two applications estimating gender gaps in citations and wages, we show that DDML with stacking is more robust to partially unknown functional forms than common alternative approaches based on single pre-selected learners. We provide Stata and R software implementing our proposals.\
_Presented at: Machine Learning in Economics Summer Institute 2022_