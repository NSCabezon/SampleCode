import UIKit
import Charts

class DetailViewController: UIViewController, AlertPresentable {
    private lazy var chartView: LineChartView = {
        let chartView = LineChartView()
        let xAxis = chartView.xAxis
        xAxis.valueFormatter = self
        xAxis.labelFont = .systemFont(ofSize: 11)
        xAxis.drawAxisLineEnabled = false
        chartView.translatesAutoresizingMaskIntoConstraints = false
        return chartView
    }()
    private var hintLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("detail_screen__hint_label", comment: "")
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var viewModel: DetailViewModelProtocol
    private var historicData: HistoricData?

    init(viewModel: DetailViewModelProtocol) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        configureViewModel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupHierarchy()
        setupConstraints()
        setupAccessibilityIds()

        viewModel.viewDidLoad()
    }
}

private extension DetailViewController {
    func configureViewModel() {
        viewModel.didGetHistoricData = { [weak self] success in
            guard let self = self else { return }
            if success {
                self.configureChart()
            } else {
                self.presentErrorAlert(message: NSLocalizedString("something_went_wrong", comment: ""),
                                       acceptCompletion: nil,
                                       viewController: self)
            }
        }
    }

    func configureChart() {
        guard let dataSets = viewModel.lineChartDataSets else { return }

        let set1 = dataSets.0
        set1.axisDependency = .left
        set1.setColor(.red)
        set1.circleRadius = 0
        set1.drawCircleHoleEnabled = false

        let set2 = dataSets.1
        set2.axisDependency = .left
        set2.setColor(.blue)
        set2.circleRadius = 0
        set2.drawCircleHoleEnabled = false

        let data = LineChartData(dataSets: [set1, set2])
        data.setValueFont(.systemFont(ofSize: 9))

        chartView.data = data

        chartView.animate(xAxisDuration: 2.5)
    }

    func setupViews() {
        view.backgroundColor = .white
        title = NSLocalizedString("detail_screen__title", comment: "")

        let xAxis = chartView.xAxis
        xAxis.valueFormatter = self
        xAxis.labelFont = .systemFont(ofSize: 11)
        xAxis.drawAxisLineEnabled = false
    }

    func setupHierarchy() {
        view.addSubview(chartView)
        view.addSubview(hintLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            chartView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: LayoutConstants.baseSpacing2),
            chartView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: LayoutConstants.baseSpacing2),
            chartView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -LayoutConstants.baseSpacing2),
            chartView.heightAnchor.constraint(equalToConstant: LayoutConstants.chartHeight),

            hintLabel.leadingAnchor.constraint(equalTo: chartView.leadingAnchor, constant: LayoutConstants.baseSpacing),
            hintLabel.trailingAnchor.constraint(equalTo: chartView.trailingAnchor, constant: -LayoutConstants.baseSpacing),
            hintLabel.topAnchor.constraint(equalTo: chartView.bottomAnchor, constant: LayoutConstants.baseSpacing2)
        ])
        hintLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
    }

    func setupAccessibilityIds() {
        chartView.accessibilityIdentifier = AccessibilityIdentifiers.DetailViewController.Chart
    }
}

extension DetailViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return viewModel.string(for: value)
    }
}
